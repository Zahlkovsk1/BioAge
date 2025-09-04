//
//  TimePicker.swift
//  BioAge
//
//  Created by Gabons on 26/08/25.
//
import SwiftUI
import MCEmojiPicker

struct EmojiDemoView: View {
    @State private var isPickerPresented = false
    @State private var selectedEmoji = "🙂"

    var body: some View {
        Button(selectedEmoji) {
            isPickerPresented.toggle()
        }
        .emojiPicker( 
            isPresented: $isPickerPresented,
            selectedEmoji: $selectedEmoji
        )
        .font(.system(size: 40))
        .padding()
    }
}


struct EmojiPickerRow: View {
    @State private var isPickerPresented = false
    @Binding var selectedEmoji: String   // pass in from parent

    var body: some View {
        HStack(spacing: 14) {
            Text("emoji")
                .bold()
                

            Spacer(minLength: 12)

            Button {
                isPickerPresented = true
            } label: {
                Text(selectedEmoji.isEmpty ? "🙂" : selectedEmoji)
                    .font(.system(size: 28))
                    .frame(width: 56, height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .stroke(Color.gray.opacity(0.25), lineWidth: 1)
                    )
                    .shadow(radius: 4, y: 2)
            }
            .buttonStyle(PressableTileStyle())
            .emojiPicker(isPresented: $isPickerPresented, selectedEmoji: $selectedEmoji)
            .accessibilityLabel("Choose emoji")
            
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.regularMaterial)
        )
    }
}

struct PressableTileStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.9), value: configuration.isPressed)
    }
}
