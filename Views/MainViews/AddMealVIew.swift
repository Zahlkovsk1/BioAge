//
//  AddMealVIew.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//
import SwiftUI
import SwiftData
import PhotosUI

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
    @State private var selectedImage: Image?
    

    
    private let calorieStep = 1
    let caloriePresets = [150, 250, 230, 500]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
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
        }
    }
    
    @ViewBuilder
    private func nutrientPicker(
        title: String,
        icon: String = "",
        value: Binding<Int>,
        unit: String,
        titleColor: Color,
        backgroundColor: Color
    ) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.subheadline).fontWeight(.semibold)
                    .foregroundColor(titleColor)
                if !icon.isEmpty {
                    Text(icon)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.systemBackground))
                    .frame(height: 140)
                
                HStack(spacing: 35) {
                    RoundIconButton(systemName: "minus") { value.wrappedValue -= 1 }
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(value.wrappedValue)").font(.system(size: 50, weight: .bold))
                        Text(unit).font(.system(size: 24, weight: .bold)).foregroundColor(.secondary)
                    }
                    RoundIconButton(systemName: "plus") { value.wrappedValue += 1 }
                }
                .padding()
            }
            .padding(.horizontal)
        }.padding(.horizontal)
    }
    
    
    private func saveMeal() {
        let newMeal = Meal(
            name: name,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat,
            fiber: fiber,
            imageName: imageName
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




struct ChipButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded))
            .fontWeight(.semibold)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(0)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.secondary.opacity(0.12))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}


struct RoundIconButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .bold))
                .frame(width: 34, height: 34)
                .foregroundStyle(.primary) // black/white with scheme
                .background(Circle().fill(Color.secondary.opacity(0.15)))
                .overlay(Circle().stroke(Color.secondary.opacity(0.25), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}
//
//Form {
//    Section(header: Text("Name")) {
//        TextField("Enter meal name", text: $name)
//            .autocapitalization(.words)
//    }
//    Section(header: Text("Calories")) {
//        Stepper(value: $calories, in: 0...10000, step: 1) {
//            Text("\(calories) calories")
//        }
//    }
//
//VStack(alignment: .leading, spacing: 8) {
//Text("Image")
//.font(.headline)
//Text("Default meal image will be used")
//.font(.caption)
//.foregroundColor(.gray)
//
//PhotosPicker(selection: $avatarItem, matching: .images) {
//ZStack {
//RoundedRectangle(cornerRadius: 12)
//   .strokeBorder(Color.gray.opacity(0.6), lineWidth: 1)
//   .background(
//       RoundedRectangle(cornerRadius: 12)
//           .fill(Color.gray.opacity(0.1))
//   )
//   .frame(height: 120)
//
//if let selectedImage {
//   selectedImage
//       .resizable()
//       .scaledToFill()
//       .frame(width: 120, height: 120)
//       .clipShape(RoundedRectangle(cornerRadius: 12))
//} else {
//   VStack(spacing: 8) {
//       Image(systemName: "photo.badge.plus.fill")
//           .font(.system(size: 45))
//       Text("Select Image")
//           .font(.caption)
//   }
//   .foregroundColor(.gray)
//}
//}
//}
//.onChange(of: avatarItem) { newItem in
//Task {
//if let data = try? await newItem?.loadTransferable(type: Data.self),
//  let uiImage = UIImage(data: data) {
//   selectedImage = Image(uiImage: uiImage)
//}
//}
//}
//}
//.padding(.horizontal)
//}

