//
//  experimentView.swift
//  BioAge
//
//  Created by Gabons on 06/08/25.
//
import SwiftUI

struct ExperimentView: View {
    @State private var protein: Int = 0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // The card
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.systemBackground))
                .frame(height: 140)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Top-left label
            Text("Protein")
                .font(.caption).fontWeight(.semibold)
                .foregroundColor(.red)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.red.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top, 8)
                .padding(.leading, 12)
            
            // Counter content
            HStack(spacing: 35) {
                Button {
                    protein = max(0, protein - 1)
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(Color.secondary))
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderless)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(protein)")
                        .font(.system(size: 50, weight: .bold, design: .rounded))
                    Text("grams")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                Button {
                    protein += 1
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(width: 44, height: 44)
                        .background(Circle().fill(Color.secondary))
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                }
                .buttonStyle(.borderless)
            }
            .padding()
        }
        .padding()
    }
}

struct ExperimentView_Previews: PreviewProvider {
    static var previews: some View {
        ExperimentView()
            .preferredColorScheme(.light)
            .padding()
    }
}
