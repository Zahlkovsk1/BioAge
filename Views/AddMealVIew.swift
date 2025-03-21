//
//  AddMealVIew.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI
import SwiftData

struct AddMealView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name = ""
    @State private var calories = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var fat = ""
    @State private var fiber = ""
    @State private var imageName = "meal-image" // Default image
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Meal Details")) {
                    TextField("Meal Name", text: $name)
                        .font(.system(.body, design: .rounded))
                }
                
                Section(header: Text("Nutrition Information")) {
                    HStack {
                        Text("🔥")
                        TextField("Calories", text: $calories)
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                    
                    HStack {
                        Text("🥩")
                        TextField("Protein (g)", text: $protein)
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                    
                    HStack {
                        Text("🍚")
                        TextField("Carbs (g)", text: $carbs)
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                    
                    HStack {
                        Text("🫒")
                        TextField("Fat (g)", text: $fat)
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                    
                    HStack {
                        Text("🥦")
                        TextField("Fiber (g)", text: $fiber)
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                }
                
                // In a real app, you would add image selection here
                Section(header: Text("Image")) {
                    Text("Default meal image will be used")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Add New Meal")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveMeal()
                }
                .font(.system(.body, design: .rounded, weight: .bold))
                .disabled(name.isEmpty)
            )
        }
    }
    
    private func saveMeal() {
        let newMeal = Meal(
            name: name,
            calories: Int(calories) ?? 0,
            protein: Int(protein) ?? 0,
            carbs: Int(carbs) ?? 0,
            fat: Int(fat) ?? 0,
            fiber: Int(fiber) ?? 0,
            imageName: imageName
        )
        
        modelContext.insert(newMeal)
        
        dismiss()
    }
}

#Preview {
    AddMealView()
}
