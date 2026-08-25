//
//  RoomOptionsView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 20.08.2026.
//

import SwiftUI

struct RoomOptionsView: View {
    @Binding var selectedOption: RoomOptionType?
    @Binding var shouldAddFurniture: Bool
    @Binding var shouldAddText: Bool
    @Binding var shouldShareImage: Bool
    
    var body: some View {
        HStack(spacing: 35) {
            ForEach(RoomOptionType.allCases, id: \.self) { type in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                        switch type {
                        case .furniture:
                            shouldAddFurniture = true
                        case .anotation:
                            shouldAddText = true
                        case .exportImage:
                            shouldShareImage = true
                            selectedOption = type // only set for export, others are transient
                        }
                    }
                } label: {
                    VStack(spacing: 8) {
                        type.icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.primary)
                        
                        Text(type.description)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 8)
                }
            }
        }
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 10)
    }
}

#Preview {
    RoomOptionsView(selectedOption: .constant(nil),
                    shouldAddFurniture: .constant(false),
                    shouldAddText: .constant(false),
                    shouldShareImage: .constant(false))
}
