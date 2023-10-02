//
//  Item.swift
//  Countero
//
//  Created by Benjamin Surrey on 22.09.23.
//

import Foundation
import SwiftData
import SwiftUI


@Model
final class Counter {
    var id: UUID = UUID()
    var timestamp: Date = Date()
    
    var title: String = ""
    var note: String?
    
    var canBeNegative: Bool?
    
    var red: Float = Color.blue.toRGB().red
    var green: Float = Color.green.toRGB().green
    var blue: Float = Color.blue.toRGB().blue
    
    var value: Int64 = 0
    var minValue: Int64?
    var maxValue: Int64?
    
    static var maxInput = 999_999_999_999
    
    public init(
        title: String,
        note: String? = nil,
        canBeNegative: Bool? = false,
        red: Float,
        green: Float,
        blue: Float,
        value: Int64,
        minValue: Int64? = nil,
        maxValue: Int64? = nil,
        timestamp: Date = .now
    ) {
        self.id = UUID()
        self.timestamp = Date()
        self.title = title
        self.note = note
        self.canBeNegative = canBeNegative
        self.red = red
        self.green = green
        self.blue = blue
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    func getColor() -> Color {
        Color.fromRGB(red: self.red, green: self.green, blue: self.blue)
    }
    
    
    static func insertSampleData(modelContext: ModelContext) {
        // Add the animal categories to the model context.
        modelContext.insert(demo)
        modelContext.insert(black)
        modelContext.insert(white)
        modelContext.insert(yellow)
        modelContext.insert(green)
    }
}
