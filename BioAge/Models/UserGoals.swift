//
//  UserSettings.swift
//  BioAge
//
//  Created by Gabons on 09/09/25.
//

import Foundation
import SwiftData
//
@Model
final class UserGoals {
    var caloriesGoal: Double
    var proteinsGoal: Double = 0
    var carbsGoal: Double = 0
    var fatsGoal: Double = 0
    var fibersGoal: Double = 0
    
    init(caloriesGoal: Double = 0, proteinsGoal: Double = 0, carbsGoal: Double = 0, fatsGoal: Double = 0, fibersGoal: Double = 0) {
        self.caloriesGoal = caloriesGoal
        self.proteinsGoal = proteinsGoal
        self.carbsGoal = carbsGoal
        self.fatsGoal = fatsGoal
        self.fibersGoal = fibersGoal
    }
}
