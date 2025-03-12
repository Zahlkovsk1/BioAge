//
//  MealsListView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI
import SwiftData

struct MealListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Meal.dateAdded, order: .reverse) private var meals: [Meal]
    @State private var showingAddMeal = false
    
    var body: some View {
        NavigationView {
            Group {
                if meals.isEmpty {
                    ContentUnavailableView(
                        "No Meals",
                        systemImage: "fork.knife",
                        description: Text("Add your first meal to get started")
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(meals) { meal in
                                MealView(meal: meal)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            deleteMeal(meal)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                        .padding(.vertical, 16)
                    }
                }
            }
            .navigationTitle("My Meals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddMeal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddMeal) {
                AddMealView()
            }
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private func deleteMeal(_ meal: Meal) {
        modelContext.delete(meal)
    }
}
