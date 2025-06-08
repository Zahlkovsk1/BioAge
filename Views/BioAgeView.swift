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
            
            ZStack {
                if combinedItems.isEmpty  {
                    ContentUnavailableView(
                        "Nothing yet",
                        systemImage: "fork.knife",
                        description: Text("Add meals or activities to get started")
                    )
                } else {
                    GeometryReader { geometry in
                        ScrollView {
                            
                            HStack {
                                ZStack {
                                    GeometryReader { geo in
                                        Path { path in
                                            let midPoint = CGPoint(x:geo.frame(in: .local).midX, y: 0)
                                            let endPoint = CGPoint(x:geo.frame(in: .local).midX, y: geo.frame(in: .local).maxY)
                                            path.move(to: midPoint)
                                            path.addLine(to: endPoint)
                                            
                                        }
                                        .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                        .opacity(0.2)
                                        .onAppear {
                                            
                                                let rect = geo.frame(in: .named("feed"))
                                                guard let frame = viewModel.frames["line"] else {
                                                   
                                                    viewModel.frames["line"] = rect
                                                    print("line is zero" )
                                                    return }
                                                                                       
                                        }
                                        
                                    }
                                    .frame(width: 15)
                                    //  .background(.yellow)
                                    
                                }
                                .padding([.leading, .vertical])
                                
                                VStack(spacing: 50) {
                                    ForEach(combinedItems, id: \.id) { item in
                                        if let meal = item as? Meal {
                                            MealView(meal: meal)
                                                .environment(viewModel)
                                                .contextMenu {
                                                    Button(role: .destructive) {
                                                        deleteMeal(meal)
                                                    } label: {
                                                        Label("Delete", systemImage: "trash")
                                                    }
                                                }
                                        } else if let activity = item as? Activity {
                                            
                                            HStack {
                                                
                                                Spacer()
                                                    .frame(width: 20)
                                                ActivityView(activity: activity)
                                                    .environment(viewModel)
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
                                    
                                }
                                .padding(
                                    .vertical
                                )
                                
                                
                                
                                Spacer()
                            }
                            
                        }
                    }
                    .coordinateSpace(name: "feed")
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
