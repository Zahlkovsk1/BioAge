//
//  DraggyView.swift
//  BioAge
//
//  Created by Gabons on 24/08/25.
//

import SwiftUI

struct TimeInputView: View {
    @Binding var hours: Int?
    @Binding var minutes: Int?
    var focusedField: FocusState<TimeField?>.Binding
    
    private enum Field { case hours, minutes }

    var body: some View {
        HStack(spacing: 20) {
            // Hours
            HStack(spacing: 6) {
                TextField("00", value: $hours, format: .number)
                    .font(.title)
                    .frame(width:  70)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused(focusedField, equals: .hours)
                    .onChange(of: hours) { _, newValue in
                        if let v = newValue { hours = min(max(v, 0), 60) }  // or 23 if you prefer
                    }
                Text("h").font(.headline)
            }
            Text(":")
                .font(.title)
                .bold()
            // Minutes
            HStack(spacing: 6) {
                TextField("00", value: $minutes, format: .number)
                    .font(.title)
                    .frame(width: 70)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                    .focused(focusedField, equals: .minutes)
                    .onChange(of: minutes) { _, newValue in
                        if let v = newValue { minutes = min(max(v, 0), 60) }  // typically 0–59
                    }
                Text("min").font(.headline)
            }
        }
    }
}


// Preview
private struct TimeInputPreviewContainer: View {
    @State var hours: Int? = 1
    @State var minutes: Int? = 30
    @FocusState private var timeFocusedField: TimeField?   // preview focus

    var body: some View {
        TimeInputView(hours: $hours, minutes: $minutes, focusedField: $timeFocusedField)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

#Preview("Interactive") {
    TimeInputPreviewContainer()
}



enum TimeField: Hashable {
    case hours
    case minutes
}
