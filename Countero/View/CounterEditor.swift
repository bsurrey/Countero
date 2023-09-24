//
//  AddView.swift
//  Countero
//
//  Created by Benjamin Surrey on 22.09.23.
//

import SwiftUI
import SwiftData

struct CounterEditor: View {
    let counter: Counter?
    
    private var editorTitle: String {
        counter == nil ? "Add Counter" : "Edit Counter"
    }
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject() private var navigationContext: NavigationContext
    
    // Info
    @State private var title: String = ""
    @State private var note: String = ""
    // Value(s)
    @State private var value: String = "0"
    @State private var minValue: String = ""
    @State private var maxValue: String = ""
    //Design
    @State private var color: Color = Color.blue
    //Bools
    @State private var canBeNegative = false
    
    @State private var addSteps: String = "1"
    @State private var removeSteps: String = "1"
    
    @State private var showNegationPane: Bool = false
    
    @FocusState var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $title)

                }
                
                NumericField(title: "Start Value", fieldValue: $value)
                
                Section {
                    ColorPicker("Color", selection: $color, supportsOpacity: false)

                }
                
                Section {
                    Toggle("Allow Negative Value", isOn: $canBeNegative)
                        .toggleStyle(SwitchToggleStyle())
                }
            }
            .actionSheet(isPresented: $showNegationPane) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/ActionSheet(title: Text("Action Sheet"))/*@END_MENU_TOKEN@*/
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(title == "")
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
        
    }
    
    private func save() {
        let color = color.toRGB()
        
        withAnimation {
            if let counter {
                // Edit the animal.
                counter.title = title
                counter.note = note
                counter.red = color.red
                counter.blue = color.blue
                counter.green = color.green
                counter.value = Int64(value) ?? 0
            } else {
                // Add an animal.
                let newCounter = Counter(
                    title: title,
                    red: color.red,
                    green: color.green,
                    blue: color.blue,
                    value: Int64(value) ?? 0
                )
                modelContext.insert(newCounter)
            }
        }
    }
}

#Preview("Add Counter") {
    ModelContainerPreview(ModelContainer.sample) {
        CounterEditor(counter: nil)
            .environmentObject(NavigationContext())
    }
}

#Preview("Edit Counter") {
    ModelContainerPreview(ModelContainer.sample) {
        CounterEditor(counter: .demo)
            .environmentObject(NavigationContext())
    }
}
