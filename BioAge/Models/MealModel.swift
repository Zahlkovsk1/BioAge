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
    var id: UUID = UUID()
    var name: String
    var calories: Int = 0
    var protein: Int = 0
    var carbs: Int = 0
    var fat: Int = 0
    var fiber: Int = 0
    @Attribute(.externalStorage) var imageData: Data?
    var dateAdded: Date

    
    init(name: String, calories: Int = 0, protein: Int = 0, carbs: Int = 0, fat: Int = 0, fiber: Int = 0, imageData: Data? = nil
         //circleColor: String = "red"
    ) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.fiber = fiber
        self.imageData = imageData
        self.dateAdded = Date()
    }
}


extension Meal {
    static var samples: [Meal] {
        [   Meal(name: "Cottage cheese, yogurt, strawberries, blueberries.", calories: 300, protein: 10, carbs: 40, fat: 8, fiber: 5, imageData: nil),
            Meal(name: "Grilled chicken salad with avocado", calories: 420, protein: 35, carbs: 12, fat: 28, fiber: 8, imageData: nil),
            Meal(name: "Oatmeal with bananas and honey", calories: 350, protein: 8, carbs: 65, fat: 5, fiber: 7, imageData: nil)
        ]
    }
}

extension Meal {
    var image: Image {
        if let data = imageData, let ui = UIImage( data: data) {
            return Image(uiImage: ui)
            
        } else {
            return Image("meal-image")
        }
    }
}
