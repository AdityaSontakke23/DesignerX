//
//  SurfaceDetailsView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 15.08.2026.
//

import SwiftUI
import RoomPlan

struct SurfaceDetailsView: View {
    @Binding var surface: FloorPlanSurface?
    @Binding var selectedType: DetailsType?
    
    @State private var angle: CGFloat = 0
    @State private var width: CGFloat = 0
    @State private var depth: CGFloat = 0
    @State private var position: CGPoint = .init(x: 0, y: 0)
    @State private var zPosition: CGFloat = 0
    @State private var selectedDirection: OpenDirection = .clockwise
    
    init(surface: Binding<FloorPlanSurface?>,
         selectedType: Binding<DetailsType?>) {
        _surface = surface
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
            
            ScrollView(.vertical, showsIndicators: false) {
                if let selectedType {
                    createDetailsContent(for: selectedType)
                }
            }
            
            Spacer()
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
            if let surface {
                let rotationInDegrees = surface.zRotation * (180 / .pi)
                let snappedAngle = round(rotationInDegrees / 15) * 15
                let normalizedAngle = snappedAngle.truncatingRemainder(dividingBy: 360)
                angle = normalizedAngle
                
                width = surface.halfLength * 2
                depth = surface.selectedShape?.lineWidth ?? 0
                position = surface.position
                zPosition = surface.zPosition
                selectedDirection = surface.openDirection
            }
        }
    }
}

// MARK: Views
private extension SurfaceDetailsView {
    func getAllSliderMesurementTypes() -> [SliderMesurementType] {
        return [.angle(angle), .width(width), .depth(depth), .xPosition(position.x), .yPosition(position.y), .zPosition(zPosition)]
    }
    
    var headerView: some View {
        HStack {
            createTitleView(from: surface)
            
            Spacer()
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    selectedType = nil
                    surface?.deselect()
                    surface = nil
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
    func createTitleView(from surface: FloorPlanSurface?) -> some View {
        if let surface {
            let surfaceCategory = surface.capturedSurface.category
            
            Text("\(getSurfaceName(for: surfaceCategory))")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
        }
    }
    
    func getSurfaceName(for type: CapturedRoom.Surface.Category) -> String {
        switch type {
        case .door:
            "The Door"
        case .wall:
            "The Wall"
        case .opening:
            "The Opening"
        case .window:
            "The Window"
        case .floor:
            "The Floor"
        @unknown default:
            "Unknown Surface"
        }
    }
    
    @ViewBuilder
    func createSliderButton(for type: DetailsType) -> some View {
        if let surface {
            switch type {
            case .measurements:
                switch surface.capturedSurface.category {
                case .wall, .window, .door:
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            selectedType = type
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: type.buttonImageName)
                                .font(.title2)
                                .foregroundStyle(selectedType == type ? .white : .blue)
                                .frame(width: 50, height: 50)
                                .background(selectedType == type ? Color.blue : Color.blue.opacity(0.1))
                                .clipShape(Circle())
                            
                            Text(type.description)
                                .font(.caption)
                                .fontWeight(selectedType == type ? .semibold : .medium)
                                .foregroundStyle(selectedType == type ? Color.primary : Color.primary.opacity(0.8))
                        }
                    }
                case .opening, .floor:
                    EmptyView()
                @unknown default: EmptyView()
                }
            case .doorDirection:
                switch surface.capturedSurface.category {
                case .window, .door:
                    Button {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                            selectedType = type
                        }
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: type.buttonImageName)
                                .font(.title2)
                                .foregroundStyle(selectedType == type ? .white : .purple)
                                .frame(width: 50, height: 50)
                                .background(selectedType == type ? Color.purple : Color.purple.opacity(0.1))
                                .clipShape(Circle())
                            
                            Text(type.description)
                                .font(.caption)
                                .fontWeight(selectedType == type ? .semibold : .medium)
                                .foregroundStyle(selectedType == type ? Color.primary : Color.primary.opacity(0.8))
                        }
                    }
                case .opening, .floor, .wall:
                    EmptyView()
                @unknown default: EmptyView()
                }
            case .delete:
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                        surface.removeFromParent()
                        selectedType = nil
                        surface.deselect()
                        self.surface = nil
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
                        let incrementedAngle = angle + 15
                        let snappedAngle = round(incrementedAngle / 15) * 15
                        let normalizedAngle = snappedAngle.truncatingRemainder(dividingBy: 360)
                        surface.updateAngleRadians(to: normalizedAngle)
                        angle = normalizedAngle
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: type.buttonImageName)
                            .font(.title2)
                            .foregroundStyle(.orange)
                            .frame(width: 50, height: 50)
                            .background(Color.orange.opacity(0.1))
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
    
    func createDetailsContent(for type: DetailsType) -> some View {
        VStack {
            switch type {
            case .measurements:
                AdjustMesurementView(
                    sliderBinding: Binding(
                        get: {
                            surface?.zRotation ?? 0
                        },
                        set: { newValue in
                            surface?.updateAngle(to: newValue)
                            angle = newValue
                        }),
                    sliderType: .angle(angle),
                    newPosition: .constant(""))
                
                AdjustMesurementView(
                    sliderBinding: Binding(
                        get: {
                            surface?.halfLength ?? 0 * 2
                        },
                        set: { newValue in
                            surface?.updateWidth(to: newValue)
                            width = newValue
                        }),
                    sliderType: .width(width),
                    newPosition: .constant(""))
                
                
                AdjustMesurementView(
                    sliderBinding: Binding(
                        get: {
                            surface?.selectedShape?.lineWidth ?? 0
                        },
                        set: { newValue in
                            surface?.updateDepth(to: newValue)
                            depth = newValue
                        }),
                    sliderType: .depth(depth),
                    newPosition: .constant(""))
                
                AdjustMesurementView(
                    sliderBinding: nil,
                    sliderType: .xPosition(position.x),
                    newPosition: Binding(
                        get: {
                            String(format: "%.2f", Float(surface?.position.x ?? 0))
                        },
                        set: { newValue in
                            if let newValueAsFloat = Float(newValue) {
                                surface?.updatePosition(x: CGFloat(newValueAsFloat))
                                position.x = CGFloat(newValueAsFloat)
                            }
                        }
                    )
                )
                
                AdjustMesurementView(
                    sliderBinding: nil,
                    sliderType: .yPosition(position.y),
                    newPosition: Binding(
                        get: {
                            String(format: "%.2f", Float(surface?.position.y ?? 0))
                        },
                        set: { newValue in
                            if let newValueAsFloat = Float(newValue) {
                                surface?.updatePosition(y: CGFloat(newValueAsFloat))
                                position.y = CGFloat(newValueAsFloat)
                            }
                        }
                    )
                )
                
                AdjustMesurementView(
                    sliderBinding: nil,
                    sliderType: .zPosition(zPosition),
                    newPosition: Binding(
                        get: {
                            String(format: "%.2f", Float(surface?.zPosition ?? 0))
                        },
                        set: { newValue in
                            if let newValueAsFloat = Float(newValue) {
                                surface?.updatePosition(z: CGFloat(newValueAsFloat))
                                zPosition = CGFloat(newValueAsFloat)
                            }
                        }
                    )
                )
            case .doorDirection:
                HStack {
                    Text("Direction:")
                        .font(.body)
                    
                    Spacer()
                    
                    Picker("Direction", selection: Binding(
                        get: {
                            selectedDirection
                        },
                        set: { newValue in
                            surface?.updateDoorOpenDirection(to: newValue)
                            selectedDirection = newValue
                        }
                    )) {
                        ForEach(OpenDirection.allCases, id: \.self) { direction in
                            Text(direction.description)
                                .tag(direction)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal, 20)
            case .delete, .rotate:
                EmptyView()
            }
        }
    }
}

#Preview {
    // Create a mock data manager
    let mockDataManager = MockDataManager()
    
    // Load a captured room safely
    let capturedRoom = mockDataManager.loadCapturedRoom()
    
    // Load a surface safely
    let surface = capturedRoom?.walls.first
    let floorPlanSurface = FloorPlanSurface(capturedSurface: surface!)
    
    // Provide the surface as a binding
    SurfaceDetailsView(surface: .constant(floorPlanSurface),
                       selectedType: .constant(nil))
}
