//
//  UserView.swift
//  BioAge
//
//  Created by Gabons on 09/09/25.
//
import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var appear = false
    @State private var isDone = false
    @State private var viewModel = DaySumViewModel.shared 
    var body: some View {
        NavigationStack {
            VStack() {

                // Circle above "Macros"
                CircularCaloriesRing(calories: $viewModel.caloriesGoal, maxCalories: 4000, lineWidth: 28,    onCaloriesChanged: { newValue in
                    
                    UserDefaults.standard.set(newValue, forKey: "caloriesGoal")
                })
                    .frame(height: 200)
                    .padding()

                // Content
                VStack {
                    HStack {
                        Text("Macros")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }

                    HStack {
                       
                    }
                }
                .padding()

                VStack {
                    HStack  {
                        Text("Activities")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                }
                .padding()

                // Action row
                HStack(spacing: 12) {
                    Button {
                        isDone.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { dismiss() }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .symbolEffect(.bounce, value: isDone)
                                .sensoryFeedback(.success, trigger: isDone)
                            Text("Done")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            }
            .padding(.top, 6)
            .onAppear { appear = true }
            .navigationTitle("Goals")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.gray.opacity(0.4))
                    }
                }
            }
        }
    }
}





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
                // Background track with subtle gradient
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [Color.orange.opacity(0.12), Color.orange.opacity(0.06)],
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
                                Color.orange.opacity(0.7),
                                Color.orange,
                                Color.orange.opacity(0.95)
                            ]),
                            center: .center
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt)
                    )
                    .rotationEffect(.degrees(-90))
                    .shadow(color: .orange.opacity(0.3), radius: 4, x: 0, y: 2)

                // Enhanced knob with burn icon
                Circle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [Color.orange.opacity(0.8), Color.orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2.5
                            )
                    )
                    .overlay(
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.orange)
                    )
                    .frame(width: lineWidth + 8, height: lineWidth + 8)
                    .offset(y: -radius)
                    .rotationEffect(.degrees(progress * 360))
                    .shadow(color: .orange.opacity(0.4), radius: 8, x: 0, y: 2)

                // Improved center content
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
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.tertiary)
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



// Toggle isDone = true when work completes; it animates and plays haptic.


//#Preview {
//    ProfileOverlay()
//}
