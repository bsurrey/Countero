//
//  ContentView.swift
//  Countero
//
//  Created by Benjamin Surrey on 22.09.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var navigationContext = NavigationContext()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            CounterListView()
                .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack {
                SingleView(counter: navigationContext.selecttedCounter ?? .demo)
            }
        }
        .environmentObject(navigationContext)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Counter.self, inMemory: true)
}
