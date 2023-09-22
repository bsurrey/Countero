//
//  Item.swift
//  Countero
//
//  Created by Benjamin Surrey on 22.09.23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
