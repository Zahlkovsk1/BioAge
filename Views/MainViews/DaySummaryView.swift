//
//  DaySummaryView.swift
//  BioAge
//
//  Created by Gabons on 22/07/25.
//
import SwiftUI
import SwiftData

struct DaySumView: View {
    @Environment(\.colorScheme) private var colorScheme

    @Query(sort: \Meal.dateAdded, order: .reverse) var meals: [Meal]
    var totalCalories: Int { meals.reduce(0) { $0 + $1.calories } }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Today")
                .font(.system(size: 24, weight: .bold))

            Group {
                HStack {
                    Text("🌙 Sleep")
                    Spacer()
                    Text("7 hours")
                        .foregroundStyle(.secondary)
                }
                ProgressView(value: 10)
                    .opacity(0.5)

                HStack {
                    Text("🔥 Burned")
                    Spacer()
                    Text("\(totalCalories) kcal")
                        .foregroundStyle(.secondary)
                }
                ProgressView(value: 10)
                    .tint(.green)
                    .opacity(0.5)

                HStack {
                    Text("🍽️ Intake")
                    Spacer()
                    Text("\(totalCalories) kcal")
                        .foregroundStyle(.secondary)
                }
                ProgressView(value: 0, total: 10)
            }
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .fontWeight(.semibold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground)) // adapts to light/dark
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
        .padding(.horizontal)
    }
}

#Preview {
    DaySumView()
}
