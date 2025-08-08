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
    var calories: Int
    var protein: Int
    var carbs: Int
    var fat: Int
    var fiber: Int
    @Attribute(.externalStorage) var imageData: Data?
    var dateAdded: Date
   // var circleColor: String
    
    init(name: String, calories: Int, protein: Int, carbs: Int, fat: Int, fiber: Int, imageData: Data? = nil
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
        //self.circleColor = circleColor
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
