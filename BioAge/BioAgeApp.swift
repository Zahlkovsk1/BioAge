//
//  BioAgeApp.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 12/03/25.
//

import SwiftUI
import SwiftData

@main
struct MealTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MealListView()
        }
        .modelContainer(for: Meal.self, isUndoEnabled: true)
    }
}
