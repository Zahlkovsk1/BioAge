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
    
    // Unused @State variables removed, as the TextField is already bound to the viewModel.
    
    var body: some View {
        NavigationStack {
            VStack() {
                
                CircularCaloriesRing(calories: $viewModel.caloriesGoal, maxCalories: 4000, lineWidth: 28, onCaloriesChanged: { newValue in
                    UserDefaults.standard.set(newValue, forKey: "caloriesGoal")
                })
                .frame(height: 200)
                .padding()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Macros")
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        Text("proteins")
                           
                            .foregroundStyle(.secondary)
                        Spacer()
                        TextField("Proteins", value: $viewModel.proteinsGoal, format: .number)
                            .bold()
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing) // Align text to the right
                            .padding()
                            .onChange(of: viewModel.proteinsGoal) { _, newValue in
                                // Limit to a maximum of 3 digits (or 999)
                                viewModel.proteinsGoal = min(newValue, 999)
                                UserDefaults.standard.set(newValue, forKey: "proteinsGoal")
                            }
                    }
                    
                    HStack {
                        Text ("carbs")
                           
                            .foregroundStyle(.secondary)
                        Spacer()
                        TextField("Carbs", value: $viewModel.carbsGoal, format: .number)
                            .bold()
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing) // Align text to the right
                            .padding()
                            .onChange(of: viewModel.carbsGoal) { _, newValue in
                                // Limit to a maximum of 3 digits (or 999)
                                viewModel.carbsGoal = min(newValue, 999)
                                UserDefaults.standard.set(newValue, forKey: "carbsGoal")
                            }
                    }
                    
                    HStack {
                        Text("fats")
                           
                            .foregroundStyle(.secondary)
                        Spacer()
                        TextField("Fats", value: $viewModel.fatsGoal, format: .number)
                            .bold()
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing) // Align text to the right
                            .padding()
                            .onChange(of: viewModel.fatsGoal) { _, newValue in
                                // Limit to a maximum of 3 digits (or 999)
                                viewModel.fatsGoal = min(newValue, 999)
                                UserDefaults.standard.set(newValue, forKey: "fatsGoal")
                            }
                    }
                    
                    HStack {
                        Text("fibers")
                            
                            .foregroundStyle(.secondary)
                        Spacer()
                        TextField("Fibers", value: $viewModel.fibersGoal, format: .number)
                            .bold()
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing) // Align text to the right
                            .padding()
                            .onChange(of: viewModel.fibersGoal) { _, newValue in
                                // Limit to a maximum of 3 digits (or 999)
                                viewModel.fibersGoal = min(newValue, 999)
                                UserDefaults.standard.set(newValue, forKey: "fibersGoal")
                            }
                    }
                }
                .padding()
                
                VStack {
                    HStack {
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

//extension View {
//  func glassmorphicBackground() -> some View {
//    self.background(
//      RoundedRectangle(cornerRadius: 18)
//        .fill(.thinMaterial)
//        .shadow(color: .white.opacity(0.15), radius: 10, x: 0, y: 5)
//    )
//  }
//}

//#Preview {
//    ProfileOverlay()
//}
