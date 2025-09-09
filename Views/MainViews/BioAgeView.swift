//
//  MealsListView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI
import SwiftData


struct BioAgeView: View {
    
    @Namespace private var profileNS
    @State private var showProfile = false
    
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
                            
                            DaySumView()
                            
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
                                        .opacity(0.1)
                                        .onAppear {
                                            
                                            let rect = geo.frame(in: .named("feed"))
                                            guard viewModel.frames["line"] != nil else {
                                                
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
                                             
                                        } else if let activity = item as? Activity {
                                            
                                            HStack {
                                                Spacer()
                                                    .frame(width: 20)
                                                ActivityView(activity: activity)
                                                    .environment(viewModel)
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
            
            .overlay(alignment: .bottomTrailing){
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
                        
//                        Button {
//                            viewModel.showingDruggyView = true
//                        } label: {
//                            Label("that view", systemImage: "person.fil")
//                        }
                    }
                    label:  {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .frame(width: 60, height: 60)
                            .background(.blue.opacity(12))
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                            .padding()
                        
                    }
            }
            
            .navigationTitle("BioAge")
            .sheet(isPresented: $viewModel.showingAddMeal) {
                AddMealView()
            }
            .sheet(isPresented: $viewModel.showingAddActivity){
                AddActivityView()
            }
            
            .background(Color(.systemGroupedBackground))
          
            .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.2)) {
                                    showProfile = true
                                }
                            } label: {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 22))
                                    .matchedGeometryEffect(id: "avatar", in: profileNS)
                            }
                        }
                    }
            
            .sheet(isPresented: $showProfile) {
                ProfileView()
                            .presentationCornerRadius(28)                   
                            .presentationBackground(.thinMaterial)
                    }
            
           
        }
        
    }
}
