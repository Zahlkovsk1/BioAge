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
    
    @State var proteinsGoal: Double = 0
    @State var carbsGoal: Double = 0
    @State var fatsGoal: Double = 0
    @State var fibersGoal: Double = 0
    
    var body: some View {
        NavigationStack {
            VStack() {

                CircularCaloriesRing(calories: $viewModel.caloriesGoal, maxCalories: 4000, lineWidth: 28,    onCaloriesChanged: { newValue in
                    
                    UserDefaults.standard.set(newValue, forKey: "caloriesGoal")
                })
                    .frame(height: 200)
                    .padding()
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Macros")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                
                    TextField("Proteins", value: $viewModel.proteinsGoal, format: .number)
                        .keyboardType(.decimalPad)
                        .padding()
                        .onChange(of: proteinsGoal) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "proteinsGoal")
                        }
                    
                    TextField("Carbs", value: $viewModel.carbsGoal, format: .number)
                        .keyboardType(.decimalPad)
                        .padding()
                        .onChange(of: carbsGoal) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "carbsGoal")
                        }
                    
                    TextField("Fats", value: $viewModel.fatsGoal, format: .number)
                        .keyboardType(.decimalPad)
                        .padding()
                        .onChange(of: fatsGoal) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "fatsGoal")
                        }
                    
                    TextField("Fibers", value: $viewModel.fibersGoal, format: .number)
                        .keyboardType(.decimalPad)
                        .padding()
                        .onChange(of: fibersGoal) { _, newValue in
                            UserDefaults.standard.set(newValue, forKey: "fibersGoal")
                        }
                }
                .padding()
                .glassmorphicBackground()
                .padding(.horizontal)

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
                        //saveGoals()
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
                    .tint(.purple)
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

extension View {
  func glassmorphicBackground() -> some View {
    self.background(
      RoundedRectangle(cornerRadius: 18)
        .fill(Material.thin)
        .shadow(color: .white.opacity(0.15), radius: 10, x: 0, y: 5)
    )
  }
}

//#Preview {
//    ProfileOverlay()
//}
