//
//  MealView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//
import SwiftUI

struct MealView: View {
    @Environment(\.colorScheme) private var colorScheme
    var meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            ZStack{
                CircleView(circleColor: .red)
                HStack{
                    
                    Text(meal.dateAdded, format: .dateTime.hour().minute().day().month(.wide))
                        .foregroundStyle(.opacity(0.7))

                    Spacer()
                }
             
            }
            .padding(.bottom)
                

            VStack(alignment: .leading, spacing: 0) {
                meal.image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                   

                Text(meal.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .lineLimit(2)
                    .padding(.horizontal, 12)
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    .foregroundStyle(.primary)

                Text("\(meal.calories) calories 🔥")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(.orange)
                    .padding()

                VStack {
                    HStack {
                        nutritionBlock(emoji: "🥩", value: "\(meal.protein)g", unit: "protein")
                        Spacer()
                        nutritionBlock(emoji: "🍚", value: "\(meal.carbs)g", unit: "carbs")
                    }
                    .padding(.horizontal, 30)

                    HStack {
                        nutritionBlock(emoji: "🫒", value: "\(meal.fat)g", unit: "fat")
                        Spacer()
                        nutritionBlock(emoji: "🥦", value: "\(meal.fiber)g", unit: "fiber")
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 22)
                }
            }
            .contextMenu {
                Button(role: .destructive) {
//                    deleteMeal(meal)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            .frame(width: 330 * 0.95)
            .clipShape(RoundedRectangle(cornerRadius: 12) )
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground)) // auto light/dark
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.separator).opacity(colorScheme == .dark ? 0.6 : 0.2), lineWidth: 1)
            )
            .shadow(
                color: Color.black.opacity(colorScheme == .dark ? 0.3 : 0.08),
                radius: colorScheme == .dark ? 6 : 4,
                x: 0, y: 2
            )
        }
        .padding(.leading)
    }
    

    func nutritionBlock(emoji: String, value: String, unit: String) -> some View {
        VStack(spacing: 2) {
            HStack {
                Text(emoji).font(.system(size: 21))
                Text(value).font(.system(size: 18, weight: .bold, design: .rounded))
            }
            Text(unit)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.secondary) // adapts automatically
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    MealView(meal: Meal.samples[0])
}
