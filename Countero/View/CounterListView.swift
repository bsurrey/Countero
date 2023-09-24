//
//  CounterListView.swift
//  Countero
//
//  Created by Benjamin Surrey on 24.09.23.
//

import SwiftUI
import SwiftData

struct CounterListView: View {
    @EnvironmentObject() private var navigationContext: NavigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Counter.title) private var counters: [Counter]
    
    @State private var isEditorPresented = false
    @State private var isSettingsPresented = false
    
    var body: some View {
        List(selection: $navigationContext.selecttedCounter) {
            ForEach(counters) { counter in
                NavigationLink(value: counter) {
                    HStack {
                            Text("\(counter.title)")
    
                        
                        Spacer()
                        
                        VStack {
                            Text("\(counter.value)")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .foregroundColor(Color.fromRGB(red: counter.red, green: counter.green, blue: counter.blue).accessibleFontColor)
                        }
                        .background(Color.fromRGB(red: counter.red, green: counter.green, blue: counter.blue))
                        .cornerRadius(8)
                    }
                    .padding(
                        EdgeInsets(
                            top: 5,
                            leading: 0,
                            bottom: 5,
                            trailing: 0
                        )
                    )
                }
            }
            .onDelete(perform: removeCounters)
            
        }
        .sheet(isPresented: $isEditorPresented) {
            CounterEditor(counter: nil)
        }
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
        }
        .overlay {
            if counters.isEmpty {
                ContentUnavailableView {
                    Label("No counter availible", systemImage: "123.rectangle.fill")
                } description: {
                    AddCounterButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                SettingsButton(isActive: $isSettingsPresented)
            }
            ToolbarItem(placement: .primaryAction) {
                AddCounterButton(isActive: $isEditorPresented)
            }
        }
        .navigationTitle("Counters")
    }
    
    private func removeCounters(at indexSet: IndexSet) {
        for index in indexSet {
            let counterToDelete = counters[index]
            if navigationContext.selecttedCounter?.persistentModelID == counterToDelete.persistentModelID {
                navigationContext.selecttedCounter = nil
            }
            modelContext.delete(counterToDelete)
        }
    }
}

private struct AddCounterButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a new Counter", systemImage: "plus")
                .help("Add a Counter")
        }
    }
}

private struct SettingsButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Settings", systemImage: "gear")
                .help("Open Settings")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            CounterListView()
                .environmentObject(NavigationContext())
        }
    }
}

#Preview("Add Counter button") {
    AddCounterButton(isActive: .constant(false))
}
