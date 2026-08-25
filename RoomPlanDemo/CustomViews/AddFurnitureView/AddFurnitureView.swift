//
//  AddFurnitureView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 18.08.2026.
//

import SwiftUI
import RoomPlan

struct AddFurnitureView: View {
    @ObservedObject var floorPlanViewModel: FloorPlanViewModel
    
    private let allFurniture = CapturedRoom.Object.Category.allCases
    
    @State private var selectedFurniture: CapturedRoom.Object.Category? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            headerView
            
            furnitureList
            
            selectedFurnitureButton
            
        }
        .padding(24)
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

// MARK: Views
private extension AddFurnitureView {
    var headerView: some View {
        HStack {
            Text("Add Furniture")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    floorPlanViewModel.furnitureToAdd = nil
                    floorPlanViewModel.shouldAddFurniture = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.secondary, Color.primary.opacity(0.1))
            }
        }
    }
    
    var furnitureList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(allFurniture, id: \.self) { object in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            selectedFurniture = object
                        }
                    } label: {
                        VStack(spacing: 12) {
                            Image(object.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding()
                                .background(selectedFurniture == object ? Color.blue.opacity(0.2) : Color.primary.opacity(0.05))
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(selectedFurniture == object ? Color.blue : Color.clear, lineWidth: 2)
                                )
                            
                            Text(object.displayName)
                                .font(.caption)
                                .fontWeight(selectedFurniture == object ? .semibold : .regular)
                                .foregroundStyle(selectedFurniture == object ? .primary : .secondary)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    @ViewBuilder
    var selectedFurnitureButton: some View {
        if let selectedFurniture {
            HStack {
                Button {
                    withAnimation {
                        floorPlanViewModel.furnitureToAdd = selectedFurniture
                        floorPlanViewModel.shouldAddFurniture = false // Auto close after picking
                    }
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                        
                        Text("Add \(selectedFurniture.displayName)")
                            .font(.headline)
                            .foregroundStyle(.white)
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
                }
            }
            .transition(.move(edge: .bottom).combined(with: .opacity))
        } else {
            Spacer().frame(height: 54) // keep the height steady
        }
    }
}

#Preview {
    AddFurnitureView(floorPlanViewModel: FloorPlanViewModel())
}
