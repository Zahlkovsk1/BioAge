//
//  CaloriesRingView.swift
//  BioAge
//
//  Created by Gabons on 10/09/25.
//

import SwiftUI

struct CircularCaloriesRing: View {
    @Binding var calories: Double
    var minCalories: Double = 0
    var maxCalories: Double = 4000
    var lineWidth: CGFloat = 24
    var onCaloriesChanged: ((Double) -> Void)?

    private var progress: Double {
        let clamped = min(max(calories, minCalories), maxCalories)
        return (clamped - minCalories) / (maxCalories - minCalories)
    }

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = size / 2
            let center = CGPoint(x: size / 2, y: size / 2)

            ZStack {
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color.purple.opacity(0.12), Color.purple.opacity(0.06)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                
                // Active arc with enhanced gradient
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                Color.purple.opacity(0.7),
                                Color.purple,
                                Color.purple.opacity(0.95)
                            ]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt)
                    )
                    .rotationEffect(.degrees(-90))
                    .shadow(color: .purple.opacity(0.3), radius: 4, x: 0, y: 2)

                //  knob with burn icon
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [Color.purple.opacity(0.8), Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2.5
                            )
                    )
                    .overlay(
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.purple)
                    )
                    .frame(width: lineWidth + 8, height: lineWidth + 8)
                    .offset(y: -radius)
                    .rotationEffect(.degrees(progress * 360))
                    .shadow(color: .purple.opacity(0.4), radius: 8, x: 0, y: 2)

                VStack(spacing: 4) {
                    Text("\(Int(calories))")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.primary, .primary.opacity(0.8)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                    Text("kcal")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.secondary)
                    
                    Image(systemName: "figure.run")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.purple)
                }
            }
            .frame(width: size, height: size)
            .contentShape(Circle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let dx = value.location.x - center.x
                        let dy = value.location.y - center.y
                        var angle = atan2(dy, dx) + .pi / 2
                        if angle < 0 { angle += 2 * .pi }
                        let newProgress = min(max(angle / (2 * .pi), 0), 1)
                        calories = minCalories + newProgress * (maxCalories - minCalories)
                    }
            )
        }
        .onChange(of: calories) { _, newValue in
                 onCaloriesChanged?(newValue)
             }
        
        .aspectRatio(1, contentMode: .fit)
    }
}
