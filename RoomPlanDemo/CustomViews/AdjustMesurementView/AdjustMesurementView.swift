//
//  AdjustMesurementView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 17.08.2026.
//

import SwiftUI

struct AdjustMesurementView: View {
    let sliderBinding: Binding<CGFloat>?
    let sliderType: SliderMesurementType
    
    @Binding var newPosition: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 25) {
                Text(sliderType.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                if sliderBinding != nil {
                    Spacer()
                    
                    Text(sliderType.convertedText)
                        .foregroundStyle(.secondary)
                } else {
                    HStack(alignment: .center) {
                        TextField(sliderType.title, text: $newPosition)
                            .foregroundStyle(.primary)
                    }
                    .padding(10)
                    .background(Color.primary.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                    )
                }
            }
            
            if let sliderBinding {
                Slider(
                    value: sliderBinding,
                    in: sliderType.closedRange,
                    label: {
                        Text(sliderType.title)
                    },
                    minimumValueLabel: {
                        Text(sliderType.minimumValueLabel)
                    },
                    maximumValueLabel: {
                        Text(sliderType.maximumValueLabel)
                    }
                )
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AdjustMesurementView(
        sliderBinding: .constant(100),
        sliderType: .angle(50),
        newPosition: .constant(""))
}
