//
//  CircleView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 11/04/25.
//

import SwiftUI

struct CircleView: View {
    @State var startDate: String = "10 pm"
    @State var endDate: String = "10 am"
    @Environment(ViewModel.self) var viewModel
    @State private var offset : CGPoint = .zero
    var body: some View {
        ZStack {
            let rectOfLine = viewModel.rectOfLine
            Circle()
                .frame(width: 10, height: 10)
                .foregroundStyle(.red)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onChange(of: viewModel.rectOfLine) {
               
                                    let rect = geo.frame(in: .global)
                                    offset.x = (viewModel.rectOfLine.origin.x - rect.origin.x) + rect.width/4
                                    print("Width: \(viewModel.rectOfLine.width/2)")
                                    print("Width: \(rect.width/2)")
                                    
                                    print("RectOfLinex: \(viewModel.rectOfLine.origin.x)")
                                    
                                    print("RectX: \(rect.origin.x)")
                                                                
                            }
                        
                    }
                
                }
                .offset(x: offset.x)
            Text("\(endDate)")
        }
        
    }
}

#Preview {
    CircleView()
}


extension CGPoint {
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}
