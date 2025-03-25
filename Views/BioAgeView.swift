//
//  MealsListView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI
import SwiftData


struct BioAgeView: View {
    
    
    @State private var viewModel = ViewModel()
  
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Meal.dateAdded, order: .reverse)
       private var meals: [Meal]
       
    @Query(sort: \Activity.dateAdded, order: .reverse)
       private var activities: [Activity]
    
    private var combinedItems: [any HealthItem] {
        let allItems: [any HealthItem] = meals + activities
            return allItems.sorted(by: { $0.dateAdded > $1.dateAdded })
        }
    
    
    
    var body: some View {
        //Just for degub purposes
        let _ = print("Meals count: \(meals.count), Activities count: \(activities.count)")
        
        NavigationStack {
            Group {
                if combinedItems.isEmpty  {
                    ContentUnavailableView(
                        "Nothing yet",
                        systemImage: "fork.knife",
                        description: Text("Add meals or activities to get started")
                    )
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(combinedItems, id: \.id) { item in
                                if let meal = item as? Meal {
                                    MealView(meal: meal)
                                        .contextMenu {
                                            Button(role: .destructive) {
                                                deleteMeal(meal)
                                            } label: {
                                                Label("Delete", systemImage: "trash")
                                            }
                                        }
                                } else if let activity = item as? Activity {
                                    ActivityView(activity: activity)
                                        .contextMenu {
                                            Button(role: .destructive ) {
                                                deleteActivity(activity)
                                            } label : {
                                                Label("Delete", systemImage: "trash")
                                            }
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
                    Menu {
                        Button {
                            viewModel.showingAddMeal = true
                        } label: {
                            Label("Add Meal", systemImage: "fork.knife")
                        }
                        
                        Button {
                            viewModel.showingAddActivity = true
                        } label: {
                            Label("Add Activity", systemImage: "figure.run")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingAddMeal) {
                AddMealView()
            }
            .sheet(isPresented: $viewModel.showingAddActivity){
                AddActivityView()
            }
            .background(Color(.systemGroupedBackground))
        }
        
    }
    
    private func deleteMeal(_ meal: Meal) {
        modelContext.delete(meal)
    }
    
    private func deleteActivity(_ activity: Activity) {
        modelContext.delete(activity)
    }
}
