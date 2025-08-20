//
//  MealViewHelpers.swift
//  BioAge
//
//  Created by Gabons on 08/08/25.
//
import SwiftUI

struct ChipButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(.headline, design: .rounded))
            .fontWeight(.semibold)
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .contentShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .padding(0)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.secondary.opacity(0.12))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.secondary.opacity(0.25), lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}



struct RoundIconButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .bold))
                .frame(width: 34, height: 34)
                .foregroundStyle(.primary) // black/white with scheme
                .background(Circle().fill(Color.secondary.opacity(0.15)))
                .overlay(Circle().stroke(Color.secondary.opacity(0.25), lineWidth: 1))
        }
        .buttonStyle(.plain)
    }
}



@ViewBuilder
 func nutrientPicker(
    title: String,
    icon: String = "",
    value: Binding<Int>,
    unit: String,
    titleColor: Color,
    backgroundColor: Color
) -> some View {
    VStack(alignment: .leading) {
        HStack {
            Text(title)
                .font(.subheadline).fontWeight(.semibold)
                .foregroundColor(titleColor)
            if !icon.isEmpty {
                Text(icon)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.systemBackground))
                .frame(height: 140)
            
            HStack(spacing: 35) {
                RoundIconButton(systemName: "minus") { value.wrappedValue -= 1 }
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(value.wrappedValue)").font(.system(size: 50, weight: .bold))
                    Text(unit).font(.system(size: 24, weight: .bold)).foregroundColor(.secondary)
                }
                RoundIconButton(systemName: "plus") { value.wrappedValue += 1 }
            }
            .padding()
        }
        .padding(.horizontal)
    }.padding(.horizontal)
}
