//
//  CircleView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 11/04/25.
//

import SwiftUI
import SwiftData

struct CircleView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Meal.dateAdded, order: .reverse)
    private var meals: [Meal]
    
    @Query(sort: \Activity.dateAdded, order: .reverse)
    private var activities: [Activity]
    
    @State var circleColor : Color = .red
    @State var startDate: String = "10 pm"
    @State var endDate: String = "10 am"
    @Environment(ViewModel.self) var viewModel
    @State private var offset : CGPoint = .zero
    var body: some View {
    
        GeometryReader { geo in
            ZStack {
                Circle()
                    .foregroundColor(circleColor.opacity(0.6))
                Circle()
                    .frame(width: geo.size.width/2, height: geo.size.height/2)
                    .foregroundStyle(.white)
            }
       
            .onAppear{
                
                    let rect = geo.frame(in: .named("feed"))
                  
                    guard let rectOfLine = viewModel.frames["line"] else{ return}
                    
                    let rLine = (rectOfLine.origin.x + rectOfLine.width / 2)
                    let rCircle = (rect.origin.x + rect.width / 2)
                    
                    let path = rLine - rCircle
                    offset.x = path

//                    print("Check the instance (appear) \(viewModel.frames.keys)" )
//                    print("rOrigin \(rect.origin)")
//                    print ("line " +  "\(viewModel.frames["line"]?.origin)")
//                    print("rectOfLine \(rLine)")
//                    print("rect \(rCircle)")
//                    
//                    print("path \(path)")
//                    print ("offset.x \(offset.x)")
                
            }
                    
            .onChange(of: viewModel.frames["line"]) {
                
                if activities.isEmpty && meals.isEmpty {
                   
                    let rect = geo.frame(in: .named("feed"))

                    guard let rectOfLine = viewModel.frames["line"] else{ return}
                    
                    let rLine = (rectOfLine.origin.x + rectOfLine.width / 2)
                    let rCircle = (rect.origin.x + rect.width / 2)
                    
                    let path = rLine - rCircle
                    offset.x = path
                    
//                    print("Check the instance (change) \(viewModel.frames.keys)" )
//                    print("rectOfLine \(rLine)")
//                    print("rect \(rCircle)")
//                    print ("line " +  "\(viewModel.frames["line"]?.origin)")
//
//                    print("path \(path)")
//                    print ("offset.x \(offset.x)")
                }
            }
                        
                
            }
            .frame(width: 16, height: 16)
            .foregroundStyle(.red)
            .offset(x: offset.x)
            
        
        
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
