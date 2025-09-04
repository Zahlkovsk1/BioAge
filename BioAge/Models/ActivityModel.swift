//
//  ActivityModel.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 14/03/25.
//

import Foundation
import SwiftData
import SwiftUICore

@Model
class Activity {
    var id: UUID = UUID()
    var dateAdded: Date
    var name: String
    var emoji : String
    var duration: Int
    var calories: Int
    var averageHeartRate: Int
    var peakHeartRate: Int
    var caloriesPerMinute: Int { duration > 0 ? calories / duration : 0 }

    
    init(name : String, emoji: String, duration: Int, calories: Int,  averageHeartRate: Int, peakHeartRate: Int
    )
    {
        self.name = name
        self.emoji = emoji
        self.duration = duration
        self.calories = calories
        self.averageHeartRate = averageHeartRate
        self.peakHeartRate = peakHeartRate
        self.dateAdded = Date()
      
    }
}

extension Activity {
    static var samples: [Activity] {
        [
            Activity(name: "Gym", emoji: "💪", duration: 18, calories: 1000,  averageHeartRate: 101, peakHeartRate: 134 ),
            Activity(name: "Running", emoji: "🏃", duration: 30, calories: 210, averageHeartRate: 145, peakHeartRate: 178 ),
            Activity(name: "Bike", emoji: "🚴", duration: 45, calories: 320, averageHeartRate: 138, peakHeartRate: 162)
        ]
    }
}
