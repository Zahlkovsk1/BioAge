//
//  AddActivity.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 14/03/25.
//

import SwiftUI
import SwiftData

struct AddActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var name  = ""
    @State private var emoji  = ""
    @State private var duration = 0
    @State private var calories = 0
    @State private var intensity = 0
    @State private var averageHeartRate = 0
    @State private var peakHeartRate = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Activity Details")) {
                    TextField("Activity Name", text: $name)
                        .font(.system(.body, design: .rounded))
                }
                
                Section(header: Text("Duration Time")) {
                    HStack {
                        Text("⏱️")
                        TextField("duration", value: $duration, format: .number )
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                }
                Section(header: Text("Intensity")) {
                    HStack {
                        Text("🔥")
                        TextField("calories", value: $calories, format: .number )
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                }
                Section(header: Text(" AVG HeartRate")) {
                    HStack {
                        Text("♥️")
                        TextField("heart rate", value: $averageHeartRate, format: .number )
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                }
                Section(header: Text("Peak HeartRate")) {
                    HStack {
                        Text("♥️")
                        TextField("heart rate", value: $peakHeartRate, format: .number )
                            .keyboardType(.numberPad)
                            .font(.system(.body, design: .rounded))
                    }
                }
            }
            .navigationTitle("neww Activity")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button( "Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        // saveActivity()
                    }
                }
            }
            .font(.system(.body, design: .rounded, weight: .bold))
            .disabled(name.isEmpty)
        }
    }
    
    private func saveActivity() {
        
        let newActivity = Activity(
            name: name,
            emoji: emoji,
            duration: duration,
            calories: calories,
            intensity: intensity,
            averageHeartRate: averageHeartRate,
            peakHeartRate: peakHeartRate
            )
        
        modelContext.insert(newActivity)
        
        dismiss()
    }
}

#Preview {
    AddActivityView()
}



