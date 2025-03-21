//
//  ActivityView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 14/03/25.
//

import SwiftUI

struct ActivityView: View {
    var activity: Activity
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Left: emoji + duration
                HStack(spacing: 12) {
                    Text(activity.emoji)
                        .font(.system(size: 36))
                    
                    VStack(alignment: .leading) {
                        Text(activity.name)
                            .font(.system(.title2, design: .rounded, weight: .bold))
                        Text("\(activity.duration)m")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Right: calories
                VStack(alignment: .trailing) {
                    Text("\(activity.calories)")
                        .font(.system(.title, design: .rounded, weight: .bold))
                        .foregroundColor(.green)
                    Text("kcal")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.green)
                }
                .padding(12)
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
            }
            .padding()
            
            Divider()
                .padding(.horizontal)
            
            // Bottom section with stats
            HStack {
                
                StatBlock(title: "Intensity", value: "\(activity.intensity)", unit: "%")
                
                Divider()
                    .frame(height: 40)
                
                StatBlock(title: "Avg HR", value: "\(activity.averageHeartRate)", unit: "bpm")
                
                Divider()
                    .frame(height: 40)
                
                StatBlock(title: "Peak HR", value: "\(activity.peakHeartRate)", unit: "bpm")
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
        .padding()
    }
}

// Helper view for the stat blocks
struct StatBlock: View {
    var title: String
    var value: String
    var unit: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.gray)
            
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(.title, design: .rounded, weight: .bold))
                
                Text(unit)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ActivityView(activity: Activity.samples[0])
        .preferredColorScheme(.light)
}
