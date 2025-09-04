//
//  AddMealVIew.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//
import SwiftUI
import SwiftData
import PhotosUI
import UIKit

struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var calories = 0
    @State private var protein = 0
    @State private var carbs = 0
    @State private var fat = 0
    @State private var fiber = 0
    @State private var imageName = "meal-image"
    @State private var avatarItem: PhotosPickerItem?
    @State private var selectedImage: Data?

    private let calorieStep = 1
    let caloriePresets = [150, 250, 330, 500]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Image")
                        .font(.headline)
                    PhotosPicker(selection: $avatarItem, matching: .images) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.gray.opacity(0.6), lineWidth: 1)
                               
                                .frame(height: 120)
                            
                            if let data = selectedImage, let ui = UIImage( data: data) {
                                Image(uiImage: ui)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 367, height: 240)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            } else {
                                VStack(spacing: 8) {
                                    Image(systemName: "photo.badge.plus.fill")
                                        .font(.system(size: 45))
                                    Text("Select Image")
                                        .font(.caption)
                                }
                                .foregroundColor(.gray)
                            }
                        }
                    }
                    .onChange(of: avatarItem) { item in
                        Task {
                            if let data = try? await item?.loadTransferable(type: Data.self) {
                                selectedImage = data
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 20) {
                    TextField("Enter meal name", text: $name)
                        .font(.title)
                        .bold()
                        .padding()

                    VStack(alignment: .leading) {
                        HStack(alignment: .firstTextBaseline, spacing: 6) {
                            TextField("0", value: $calories, format: .number)
                                .keyboardType(.numberPad)
                                .font(.title.weight(.bold))
                                .monospacedDigit()
                                .textFieldStyle(.plain)
                                .fixedSize(horizontal: true, vertical: false)
                                .onChange(of: calories) { newValue in
                                    calories =  max(0, newValue)
                                }
                            
                            Text("calories 🔥")
                                .font(.title.weight(.bold))
                            Spacer()
                               RoundIconButton(systemName: "minus") { adjustCalories(-calorieStep) }
                               RoundIconButton(systemName: "plus") { adjustCalories(calorieStep) }
                        }
                        
                        HStack(spacing: 12) {
                            ForEach(Array(caloriePresets.enumerated()), id: \.offset) { _, preset in
                                Button("\(preset)") {
                                    calories += preset
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                }
                                .buttonStyle(ChipButtonStyle())
                                .frame(maxWidth: .infinity)
                                .accessibilityLabel("Add \( preset) calories")
                                
                            }
                        }
                        .padding(.horizontal)
                        
                    }.padding()
                    
                    // Nutritionals Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Macros")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        // Protein (Red)
                        nutrientPicker(
                            title: "Protein",
                            icon: "",
                            value: $protein,
                            unit: "grams",
                            titleColor: .red,
                            backgroundColor: Color.red.opacity(0.1)
                        )
                        
                        // Carbs (Blue)
                        nutrientPicker(
                            title: "Carbs",
                            icon: "",
                            value: $carbs,
                            unit: "grams",
                            titleColor: .blue,
                            backgroundColor: Color.blue.opacity(0.1)
                        )
                        
                        // Fiber (Green)
                        nutrientPicker(
                            title: "Fiber",
                            icon: "",
                            value: $fiber,
                            unit: "grams",
                            titleColor: .green,
                            backgroundColor: Color.green.opacity(0.1)
                        )
                        
                        // Fat (Yellow)
                        nutrientPicker(
                            title: "Fat",
                            icon: "",
                            value: $fat,
                            unit: "grams",
                            titleColor: .yellow,
                            backgroundColor: Color.yellow.opacity(0.1)
                        )
                    }
                    .padding(.vertical)
                }
                .padding(.vertical)
            }
            .navigationTitle("Add New Meal")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveMeal()
                    }
                    .font(.body.bold())
                    .disabled(name.isEmpty)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func saveMeal() {
        let newMeal = Meal(
            name: name,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat,
            fiber: fiber,
            imageData: selectedImage
        )
        modelContext.insert(newMeal)
        dismiss()
    }
    
    private func adjustCalories(_ delta: Int) {
        let newValue = max(0, calories + delta)  // no upper cap
        if newValue != calories {
            calories = newValue
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}

#Preview {
    AddMealView()
}
