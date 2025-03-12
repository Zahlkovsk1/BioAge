//
//  MealView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI

struct MealView: View {

    var mealName: String = "Cottage cheese, yogurt, strawberries, blueberries."
    var calories: Int = 300
    var protein: Int = 10
    var carbs: Int = 40
    var fat: Int = 8
    var fiber: Int = 5
    var mealImage: String = "meal-image"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
           
            Image(mealImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height:190)
                .clipped()
            
            // Meal name
            Text(mealName)
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 4)
            
            // Nutrition info
            HStack(spacing: 0) {
                // Calories
                nutritionBlock(
                    emoji: "🔥",
                    value: "\(calories)",
                    unit: "calories"
                )
                
                // Protein
                nutritionBlock(
                    emoji: "🥩",
                    value: "\(protein)g",
                    unit: "protein"
                )
                
                // Carbs
                nutritionBlock(
                    emoji: "🍚",
                    value: "\(carbs)g",
                    unit: "carbs"
                )
                
                // Fat
                nutritionBlock(
                    emoji: "🫒",
                    value: "\(fat)g",
                    unit: "fat"
                )
                
                // Fiber
                nutritionBlock(
                    emoji: "🥦",
                    value: "\(fiber)g",
                    unit: "fiber"
                )
            }
            .padding(.bottom, 8) // Reduced padding
        }
        .frame(width: 310)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .padding(.horizontal)
    }
    
    func nutritionBlock(emoji: String, value: String, unit: String) -> some View {
        VStack(spacing: 2) {
            Text(emoji)
                .font(.system(size: 18))
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
            
            Text(unit)
                .font(.system(size: 10))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
    }
}

#Preview {
    MealView()
        .preferredColorScheme(.light)
}
