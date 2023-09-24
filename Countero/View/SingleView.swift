//
//  SingleView.swift
//  Countero
//
//  Created by Benjamin Surrey on 22.09.23.
//

import SwiftUI
import SwiftData

struct SingleView: View {
    var counter: Counter
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject() private var navigationContext: NavigationContext
    @Environment(\.presentationMode) var presentation
        
    var primaryColor: Color  {
        self.counter.getColor() 
    }
    
    @State private var showInfoSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            
            GeometryReader { geometry in
                VStack {
                    Text("\(counter.value)")
                        .font(.system(size: self.fontSize(for: geometry.size)))
                        .lineLimit(1)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .cornerRadius(16)
                        .padding()
                }
            }
            .padding()

            Spacer()
            
            HStack(alignment: .bottom) {
                Button(action: decrease) {
                    Text("-")
                        .font(.largeTitle)
                        .frame( minWidth: 0, maxWidth: 100, minHeight: 0, maxHeight: 100)
                        .background(primaryColor)
                        .clipShape(Rectangle())
                        .cornerRadius(16)
                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                        .foregroundColor(primaryColor.accessibleFontColor)
                }
                
                Spacer()
                
                Button(action: increase) {
                    Text("+")
                        .font(.largeTitle)
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100)
                        .background(primaryColor)
                        .clipShape(Rectangle())
                        .cornerRadius(16)
                        .aspectRatio(CGSize(width: 7, height: 3), contentMode: .fit)
                        .foregroundColor(primaryColor.accessibleFontColor)
                }
            }
            .frame(maxHeight: 100)
            .padding(.horizontal)
            .font(.system(size: 28, weight: .light, design: .default))
        }
        .padding(.bottom)
        .tint(Color.black)
        .navigationTitle(counter.title)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: { showInfoSheet.toggle() }) {
                    Label("Edit", systemImage: "slider.horizontal.3")
                }
                
                Button(action: { showInfoSheet.toggle() }) {
                    Label("Edit", systemImage: "square.split.2x1")
                }
            }
        }
        .sheet(isPresented: $showInfoSheet) {
            CounterEditor(counter: counter)
        }
    }
    
    func fontSize(for size: CGSize) -> CGFloat {
        if size.width < 350 { // smaller devices like iPhone SE
            return 34 // reduced font size
        } else {
            return 64 // default font size
        }
    }
    
    func decrease() {
        if counter.value < Counter.maxInput && counter.value > -Counter.maxInput {
            counter.value -= 1
        }
    }
    
    func increase() {
        if counter.value < Counter.maxInput && counter.value > -Counter.maxInput {
            counter.value += 1
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        SingleView(counter: .demo)
            .environmentObject(NavigationContext())
    }
}
