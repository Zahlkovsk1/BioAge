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
    var intensity: Int
    var averageHeartRate: Int
    var peakHeartRate: Int
    //var circleColor: String

    
    init(name : String, emoji: String, duration: Int, calories: Int, intensity: Int, averageHeartRate: Int, peakHeartRate: Int
         //circleColor: String = ""
    )
    {
        self.name = name
        self.emoji = emoji
        self.duration = duration
        self.calories = calories
        self.intensity = intensity
        self.averageHeartRate = averageHeartRate
        self.peakHeartRate = peakHeartRate
        self.dateAdded = Date()
        //self.circleColor = circleColor
    }
}

extension Activity {
    static var samples: [Activity] {
        [
            Activity(name: "Gym", emoji: "💪", duration: 18, calories: 1000, intensity: 0, averageHeartRate: 101, peakHeartRate: 134 ),
            Activity(name: "Running", emoji: "🏃", duration: 30, calories: 210, intensity: 65, averageHeartRate: 145, peakHeartRate: 178  ),
            Activity(name: "Bike", emoji: "🚴", duration: 45, calories: 320, intensity: 75, averageHeartRate: 138, peakHeartRate: 162 )
        ]
    }
}
