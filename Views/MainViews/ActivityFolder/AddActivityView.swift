//
//  AddActivity.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 14/03/25.
//

import SwiftUI
import SwiftData
import MCEmojiPicker

struct AddActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var selectedTime = Date()
    @State private var selectedSecond = 0
    
    @State private var isPickerPresented = false

    @State private var emoji = ""
    
    @State var hours: Int?
    @State var minutes: Int?
    @FocusState private var isTextFieldFocused: Bool
    @FocusState private var timeFocusedField: TimeField?
        
    @State private var name  = ""

    @State private var duration = 0
    @State private var calories = 0
    @State private var averageHeartRate: Int?
    @State private var peakHeartRate : Int?
    
    let caloriePresets = [150, 250, 330, 500]
    private let calorieStep = 1
    
    var body: some View {
        NavigationStack {
            ScrollView {
      
            
            VStack {
                TextField("Enter activity name", text: $name)
                    .font(.title)
                    .bold()
                    .padding()
            }
                
                
                VStack(spacing: 16) {
                    HStack {
                        Text("Peak heart rate")
                            .bold()
                        Spacer()
                        
                        TextField("00", value: $peakHeartRate, format: .number)
                            .frame(width: 40)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                            .onChange(of: peakHeartRate) { oldValue, newValue in
                                if let value = newValue {
                                    peakHeartRate = min(max(value, 0), 200)
                                }
                            }
                            .focused($isTextFieldFocused)
                
                    }

                    HStack {
                        Text("AVG Heart Rate")
                            .bold()
                        Spacer()
                        TextField("00", value: $averageHeartRate, format: .number)
                            .frame(width: 40)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                            .onChange(of: averageHeartRate) { oldValue, newValue in
                                if let value = newValue {
                                    averageHeartRate = min(max(value, 0), 200)
                                }
                            }
                            .focused($isTextFieldFocused)
                      
                    }
                    
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                
                EmojiPickerRow(selectedEmoji: $emoji)
                    .padding()
                
                HStack {
                    VStack(alignment: .leading)  {
                        Text("Duration Time ⏱️")
                            .font(.title)
                            .bold()
                        TimeInputView(hours: $hours,
                                      minutes: $minutes,
                                      focusedField: $timeFocusedField)
                    }
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        TextField("0", value: $calories, format: .number)
                            .keyboardType(.numberPad)
                            .font(.title.weight(.bold))
                            .monospacedDigit()
                            .textFieldStyle(.plain)
                            .fixedSize(horizontal: true, vertical: false)
                            .onChange(of: calories) { newValue in
                                calories =  max(0, newValue)
                            }
                        
                        Text("calories 🔥")
                            .font(.title.weight(.bold))
                        Spacer()
                           RoundIconButton(systemName: "minus") { adjustCalories(-calorieStep) }
                           RoundIconButton(systemName: "plus") { adjustCalories(calorieStep) }
                    }
                    
                    HStack(spacing: 12) {
                        ForEach(Array(caloriePresets.enumerated()), id: \.offset) { _, preset in
                            Button("\(preset)") {
                                calories += preset
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }
                            .buttonStyle(ChipButtonStyle())
                            .frame(maxWidth: .infinity)
                            .accessibilityLabel("Add \( preset) calories")
                            
                        }
                    }
                    .padding(.horizontal)
                    
                }.padding()
             
            .navigationTitle("new activity")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveActivity()
                }
                    .font(.system(.body, design: .rounded, weight: .bold))
                    .disabled(name.isEmpty || calculateDuration() == 0)
            )
            .navigationBarTitleDisplayMode(.inline)
        }
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Confirm") {
                        isTextFieldFocused = false
                        timeFocusedField = nil
                    }
                    .bold()
                }
            }
        }
        
    }
    
    private func saveActivity() {

        let newActivity = Activity(
            name: name,
            emoji: emoji,
            duration: calculateDuration(),
            calories: calories,
            averageHeartRate: averageHeartRate ?? 0,
            peakHeartRate: peakHeartRate ?? 0
            )
        print("Creating activity: \(newActivity.name), emoji: \(newActivity.emoji), date: \(newActivity.dateAdded)")
        
        modelContext.insert(newActivity)
        
        dismiss()
    }
    
    private func calPerMin () -> Int {
        let calPerMin = calories / calculateDuration()
        return calPerMin
    }
    
    private func adjustCalories(_ delta: Int) {
        let newValue = max(0, calories + delta)
        if newValue != calories {
            calories = newValue
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
    
    func calculateDuration() -> Int {
        let minsFromHour = (hours ?? 0) * 60
        let totalduration = minsFromHour + (minutes ?? 0)
        
        return totalduration
    }
    

}

#Preview {
    AddActivityView()
}
