//
//  NumericField.swift
//  Countero
//
//  Created by Benjamin Surrey on 22.09.23.
//

import SwiftUI
import Combine


struct NumericField: View {
    var title: String
    @Binding var fieldValue: String
    @FocusState private var isInputActive: Bool

    var body: some View {
        HStack {
            TextField(title, text: $fieldValue)
                .keyboardType(.numberPad)
                .focused($isInputActive)
                .onReceive(Just(fieldValue)) { newValue in
                    var filtered = newValue.filter { "-+0123456789".contains($0) }

                    // Remove leading zeros
                    while filtered.starts(with: "0") && filtered.count > 1 && !filtered.hasPrefix("0.") {
                        filtered.removeFirst()
                    }

                    if filtered != newValue {
                        self.fieldValue = filtered
                    }
                }
            Stepper {
                EmptyView()
            } onIncrement: {
                var tempInt = Int64(fieldValue) ?? 0
                tempInt += 1
                fieldValue = String(tempInt)
            } onDecrement: {
                var tempInt = Int64(fieldValue) ?? 0
                tempInt -= 1
                fieldValue = String(tempInt)
            }

        }
    }
}


#Preview {
    VStack {
        NumericField(title: "Start", fieldValue: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
        NumericField(title: "", fieldValue: .constant("-718278378"))
            .previewLayout(.sizeThatFits)
            .padding()
        NumericField(title: "718278", fieldValue: .constant("783728784"))
            .previewLayout(.sizeThatFits)
            .padding()
        
        NumericField(title: "718278", fieldValue: .constant("0"))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
