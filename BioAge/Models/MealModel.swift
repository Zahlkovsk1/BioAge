//
//  MealModel.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI
import SwiftData

@Model
class Meal {
    var name: String
    var calories: Int
    var protein: Int
    var carbs: Int
    var fat: Int
    var fiber: Int
    var imageName: String
    var dateAdded: Date
    
    init(name: String, calories: Int, protein: Int, carbs: Int, fat: Int, fiber: Int, imageName: String) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.fiber = fiber
        self.imageName = imageName
        self.dateAdded = Date()
    }
}

// Sample data
extension Meal {
    static var samples: [Meal] {
        [
            Meal(name: "Cottage cheese, yogurt, strawberries, blueberries.", calories: 300, protein: 10, carbs: 40, fat: 8, fiber: 5, imageName: "meal-image"),
            Meal(name: "Grilled chicken salad with avocado", calories: 420, protein: 35, carbs: 12, fat: 28, fiber: 8, imageName: "meal-image"),
            Meal(name: "Oatmeal with bananas and honey", calories: 350, protein: 8, carbs: 65, fat: 5, fiber: 7, imageName: "meal-image")
        ]
    }
}
