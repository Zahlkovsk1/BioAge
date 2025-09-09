//
//  ViewModelDaySummary.swift
//  BioAge
//
//  Created by Gabons on 08/09/25.
//

import SwiftUI
import SwiftData
import Observation

@Observable
final class DaySumViewModel {
    var isExpanded = false
    
    // MARK: - Calorie Calculations
    
    func burnedCalories(from activities: [Activity]) -> Int {
        activities.reduce(0) { $0 + $1.calories }
    }
    
    func intakeCalories(from meals: [Meal]) -> Int {
        meals.reduce(0) { $0 + $1.calories }
    }
    
    func netCalories(from meals: [Meal], activities: [Activity]) -> Int {
        intakeCalories(from: meals) - burnedCalories(from: activities)
    }
    
    // MARK: - Nutrition Calculations
    
    func totalProteins(from meals: [Meal]) -> Int {
        meals.reduce(0) { $0 + $1.protein }
    }
    
    func totalCarbs(from meals: [Meal]) -> Int {
        meals.reduce(0) { $0 + $1.carbs }
    }
    
    func totalFats(from meals: [Meal]) -> Int {
        meals.reduce(0) { $0 + $1.fat }
    }
    
    func totalFibers(from meals: [Meal]) -> Int {
        meals.reduce(0) { $0 + $1.fiber }
    }
    
    // MARK: - UI Helpers
    
    var cardAnimation: Animation {
        if #available(iOS 17.0, *) {
            return .spring(response: 0.35, dampingFraction: 0.86, blendDuration: 0.2)
        }
    }
          
        
    
    
    func toggleExpansion() {
        isExpanded.toggle()
    }
    
    // MARK: - Progress Calculations
    
    func burnedCaloriesProgress(burnedCalories: Int, goal: Double = 500.0) -> Double {
        Double(burnedCalories) / goal
    }
    
    func intakeCaloriesProgress(intakeCalories: Int, goal: Double = 2000.0) -> Double {
        Double(intakeCalories) / goal
    }
    
    func dailyGoalProgressForMacros() -> Double {
       100.0 //TODO DAily Goal
    }
    
    func dailyGoalProgressForCalories() -> Double {
        10000.0
    }
}

