//
//  MealView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//
import SwiftUI
import SwiftData

struct MealView: View {
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
     
            Image(meal.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 190)
                .clipped()
            
            Text(meal.name)
                .font(.system(.subheadline, design: .rounded))
                .lineLimit(2)
                .padding(.horizontal, 12)
                .padding(.top, 12)
                .padding(.bottom, 8)

            HStack(spacing: 0) {
                // Calories
                nutritionBlock(
                    emoji: "🔥",
                    value: "\(meal.calories)",
                    unit: "calories"
                )
                
                // Protein
                nutritionBlock(
                    emoji: "🥩",
                    value: "\(meal.protein)g",
                    unit: "protein"
                )
                
                // Carbs
                nutritionBlock(
                    emoji: "🍚",
                    value: "\(meal.carbs)g",
                    unit: "carbs"
                )
                
                // Fat
                nutritionBlock(
                    emoji: "🫒",
                    value: "\(meal.fat)g",
                    unit: "fat"
                )
                
                // Fiber
                nutritionBlock(
                    emoji: "🥦",
                    value: "\(meal.fiber)g",
                    unit: "fiber"
                )
            }
            .padding(.bottom, 16)
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
                .font(.system(size: 16, weight: .bold, design: .rounded))
            
            Text(unit)
                .font(.system(size: 10, design: .rounded))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 4)
    }
}
