//
//  ObjectDetailsView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 20.08.2026.
//

import SwiftUI
import RoomPlan

struct ObjectDetailsView: View {
    @Binding var object: FloorPlanObject?
    @Binding var selectedType: DetailsType?
    
    @State private var angle: CGFloat = 0
    
    init(object: Binding<FloorPlanObject?>,
         selectedType: Binding<DetailsType?>) {
        _object = object
        _selectedType = selectedType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    headerView
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(DetailsType.allCases, id: \.self) { type in
                                createSliderButton(for: type)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding(24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 10)
        .onAppear {
            if let object {
                let rotationInDegrees = object.zRotation * (180 / .pi)
                let snappedAngle = round(rotationInDegrees / 15) * 15
                let normalizedAngle = snappedAngle.truncatingRemainder(dividingBy: 360)
                angle = normalizedAngle
            }
        }
    }
}

// MARK: Views
private extension ObjectDetailsView {
    var headerView: some View {
        HStack {
            createTitleView(from: object)
            
            Spacer()
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    selectedType = nil
                    object?.deselect()
                    object = nil
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.secondary, Color.primary.opacity(0.1))
            }
        }
    }
    
    @ViewBuilder
    func createTitleView(from surface: FloorPlanObject?) -> some View {
        if let object {
            let objectCategory = object.capturedObject.category
            
            Text("\(objectCategory.displayName)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
        }
    }
    
    @ViewBuilder
    func createSliderButton(for type: DetailsType) -> some View {
        if let object {
            switch type {
            case .measurements, .doorDirection:
                EmptyView()
            case .delete:
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                        object.removeFromParent()
                        selectedType = nil
                        object.deselect()
                        self.object = nil
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: type.buttonImageName)
                            .font(.title2)
                            .foregroundStyle(.red)
                            .frame(width: 50, height: 50)
                            .background(Color.red.opacity(0.1))
                            .clipShape(Circle())
                        
                        Text(type.description)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                }
            case .rotate:
                Button {
                    withAnimation {
                        let incrementedAngle = angle + 15 // Use 15 instead of 10 to match standard snap
                        let snappedAngle = round(incrementedAngle / 15) * 15
                        let normalizedAngle = snappedAngle.truncatingRemainder(dividingBy: 360)
                        object.updateAngle(to: normalizedAngle)
                        angle = normalizedAngle
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: type.buttonImageName)
                            .font(.title2)
                            .foregroundStyle(.blue)
                            .frame(width: 50, height: 50)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(Circle())
                        
                        Text(type.description)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                }
            }
        }
    }
}

#Preview {
    ObjectDetailsView(object: .constant(nil),
                      selectedType: .constant(.measurements))
}
