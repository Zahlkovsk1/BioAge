//
//  ActivityView.swift
//  BioAge
//
//  Created by Shohjakhon Mamadaliev on 14/03/25.
//

import SwiftUI
import SwiftData

struct ActivityView: View {
    
    @Query(sort: \Activity.dateAdded, order: .reverse)
    private var activities: [Activity]
    @Environment(\.modelContext) private var modelContext
    
    var activity: Activity
    var presenter : ActivityViewPresenter?
    var body: some View {
        VStack(spacing: 0) {
            ZStack{
                CircleView(circleColor: .blue)
                HStack{
                    Text(activity.dateAdded, format: .dateTime.hour().minute().day().month(.wide))
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            .padding(.bottom)
                
            VStack(spacing: 0) {
                HStack {
                    HStack(spacing: 8) {
                        Text(activity.emoji)
                            .font(.system(size: 36))
                        
                        VStack(alignment: .leading) {
                            Text(activity.name)
                                .font(.system(.title2, design: .rounded, weight: .bold))
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            Text("\(activity.duration)m")
                                .font(.system(.headline, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(activity.calories)")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .foregroundColor(.green)
                        Text("kcal")
                            .font(.system(.subheadline, design: .rounded))
                            .foregroundColor(.green)
                    }
                    .padding(10)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                
                Divider()
                    .padding(.horizontal, 8)
                
                // Bottom section with stats
                HStack {
                    StatBlock(title: "Cal/min", value: "\(activity.caloriesPerMinute)", unit: "kcal")
                    
                    Divider()
                        .frame(height: 40)
                    
                    StatBlock(title: "Avg HR", value: "\(activity.averageHeartRate)", unit: "bpm")
                    
                    Divider()
                        .frame(height: 40)
                    
                    StatBlock(title: "Peak HR", value: "\(activity.peakHeartRate)", unit: "bpm")
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
            }
            .frame(width: 350 * 0.95)
            .background(.regularMaterial)
            .cornerRadius(20)
            .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 0, y: 5)
            .contextMenu {
                Button(role: .destructive) {
                    deleteActivity(activity)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
    
    private func deleteActivity(_ activity: Activity) {
        modelContext.delete(activity)
    }
}

struct StatBlock: View {
    var title: String
    var value: String
    var unit: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(unit)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ActivityView(activity: Activity.samples[0])
}
