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
    @State private var stepSize: String = "1"

    //Design
    @State private var color: Color = Color.blue
    //Bools
    @State private var canBeNegative = false
    
    @State private var showNegationPane: Bool = false
    
    @FocusState var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Information"), content: {
                    TextField("Name", text: $title)
                })
                
                Section(header: Text("Value"), content: {
                    NumericField(title: "Start Value", fieldValue: $value)
                        .onChange(of: value) { oldValue, newValue in
                            if newValue.isEmpty {
                                value = String(0)
                            }
                            
                            if Int64(newValue) ?? 0 < 0 {
                                value = String(0)
                            }
                        }
                })
                
                Section(header: Text("Step Size")) {
                    NumericField(title: "Step Size", fieldValue: $stepSize)
                        .onChange(of: stepSize) { oldValue, newValue in
                            if newValue.isEmpty {
                                stepSize = String(1)
                            }
                            
                            if Int64(newValue) ?? 1 < 1 {
                                stepSize = String(1)
                            }
                        }
                }
                
                Section {
                    ColorPicker("Accent color", selection: $color, supportsOpacity: false)
                }
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
            .onAppear {
                if let counter {
                    title = counter.title
                    value = String(counter.value)
                    color = counter.getColor()
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
