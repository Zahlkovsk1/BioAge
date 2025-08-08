//
//  DaySummaryView.swift
//  BioAge
//
//  Created by Gabons on 22/07/25.
//
import SwiftUI

struct DaySumView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Group {
                HStack {
                    Text("Sleep")
                    Spacer()
                    Text("7 hours")
                }
                ProgressView(value: 10)
                    .opacity(0.5)
                HStack {
                    Text("Burned")
                    Spacer()
                    Text("500 kcal")
                }
                ProgressView(value: 10)
                    .tint(.green)
                    .opacity(0.5)
                HStack {
                    Text("Intake")
                    Spacer()
                    Text("0 kcal")
                }
                ProgressView(value: 0, total: 10)
            }
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .fontWeight(.semibold)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

#Preview {
    DaySumView()
}
