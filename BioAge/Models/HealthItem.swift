//
//  HealthItem.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 25/03/25.
//

import Foundation

protocol HealthItem: Identifiable {
    var id: UUID { get }
    var dateAdded: Date { get }
}


extension Meal: HealthItem {}
extension Activity: HealthItem {}
