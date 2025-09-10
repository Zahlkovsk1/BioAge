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
    
    static let shared = DaySumViewModel()
    private init() {
        loadGoalsFromUserDefaults()
    }
    
    var isExpanded = false
    var caloriesGoal: Double = 2100 {
        didSet {
            UserDefaults.standard.set(caloriesGoal, forKey: "caloriesGoal")
        }
    }
    
    var proteinsGoal: Double = 0 {
        didSet {
            UserDefaults.standard.set(proteinsGoal, forKey: "proteinsGoal")
        }
    }
    
    var carbsGoal: Double = 0 {
        didSet {
            UserDefaults.standard.set(carbsGoal, forKey: "carbsGoal")
        }
    }
    
    var fibersGoal: Double = 0 {
        didSet {
            UserDefaults.standard.set(fibersGoal, forKey: "fibersGoal")
        }
    }
    
    var fatsGoal: Double = 0 {
        didSet {
            UserDefaults.standard.set(fatsGoal, forKey: "fatsGoal")
        }
    }
    
    private func loadGoalsFromUserDefaults() {
        let storedCalories = UserDefaults.standard.double(forKey: "caloriesGoal")
        if storedCalories > 0 {
            caloriesGoal = storedCalories
        }
        
        if UserDefaults.standard.object(forKey: "proteinsGoal") != nil {
            proteinsGoal = UserDefaults.standard.double(forKey: "proteinsGoal")
        }
        
        if UserDefaults.standard.object(forKey: "carbsGoal") != nil {
            carbsGoal = UserDefaults.standard.double(forKey: "carbsGoal")
        }
        
        if UserDefaults.standard.object(forKey: "fatsGoal") != nil {
            fatsGoal = UserDefaults.standard.double(forKey: "fatsGoal")
        }
        
        if UserDefaults.standard.object(forKey: "fibersGoal") != nil {
            fibersGoal = UserDefaults.standard.double(forKey: "fibersGoal")
        }
    }
    
    private var hasLoadedGoal = false
    
 
    
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
    
    // MARK: UI Helpers
    
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
        caloriesGoal
    }
    
    
}



