//
//  ActivitiyViewPresenter.swift
//  BioAge
//
//  Created by Gabons on 17/08/25.
//


import SwiftData
import SwiftUI

class ActivityViewPresenter: ObservableObject {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Meal.dateAdded, order: .reverse)
    private var meals: [Meal]
    
    
    private func deleteMeal(_ meal: Meal) {
        modelContext.delete(meal)
    }

}



