//
//  SampleData+Counter.swift
//  Countero
//
//  Created by Benjamin Surrey on 24.09.23.
//

import Foundation
import SwiftUI

extension Counter {
    static let demo = Counter(
        title: "Demo",
        red: Color.blue.toRGB().red,
        green: Color.blue.toRGB().green,
        blue: Color.blue.toRGB().blue,
        value: 123
    )
    static let black = Counter(
        title: "Black",
        red: Color.black.toRGB().red,
        green: Color.black.toRGB().green,
        blue: Color.black.toRGB().blue,
        value: 123456
    )
    static let white = Counter(
        title: "White",
        red: Color.white.toRGB().red,
        green: Color.white.toRGB().green,
        blue: Color.white.toRGB().blue,
        value: 1234
    )
    static let yellow = Counter(
        title: "Yellow",
        red: Color.yellow.toRGB().red,
        green: Color.yellow.toRGB().green,
        blue: Color.yellow.toRGB().blue,
        value: 12
    )
    static let green = Counter(
        title: "Green",
        red: Color.green.toRGB().red,
        green: Color.green.toRGB().green,
        blue: Color.green.toRGB().blue,
        value: 1234567
    )
}
