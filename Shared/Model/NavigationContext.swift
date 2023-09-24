//
//  NavigationContext.swift
//  Countero
//
//  Created by Benjamin Surrey on 24.09.23.
//
//  Abstract:
//  An observable type that manages attributes of the app's navigation system.

import SwiftUI

// For more information, see the iOS & iPadOS 17 Release Notes. (113978783)
class NavigationContext: ObservableObject {
    @Published var selecttedCounter: Counter?
    @Published var columnVisibility: NavigationSplitViewVisibility
    
    var contentListTitle: String = "Counters"
    
    init(
        selecttedCounter: Counter? = nil,
        columnVisibility: NavigationSplitViewVisibility = .automatic
    ) {
        self.selecttedCounter = selecttedCounter
        self.columnVisibility = columnVisibility
    }
}
