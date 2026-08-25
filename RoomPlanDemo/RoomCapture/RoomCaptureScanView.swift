//
//  RoomCaptureScanView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 14.08.2026.
//

import SwiftUI
import SpriteKit
import RoomPlan
import SceneKit

struct RoomCaptureScanView: View {
    // MARK: - Properties & State
    @StateObject private var viewModel: RoomCaptureViewModel = .init()
    @StateObject private var floorPlanViewModel = FloorPlanViewModel()
    @StateObject private var mockDataManager = MockDataManager()
    
    private let isDemo: Bool
    
    init(isDemo: Bool = false) {
        self.isDemo = isDemo
    }
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - View Body
    var body: some View {
        ZStack {
            mainRoomView
            
            // MARK: - Top Floating Navigation Bar
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.primary.opacity(0.1), lineWidth: 1))
                    }
                    .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
                    
                    Spacer()
                    
                    if !isDemo && !viewModel.isShowingFloorPlan {
                        topFloatingToolbar
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50) // Safely below notch
                Spacer()
            }
            .zIndex(10)
            
            // MARK: - Floating Bottom Panels
            
            if floorPlanViewModel.selectedObject != nil {
                VStack {
                    Spacer()
                    ObjectDetailsView(
                        object: $floorPlanViewModel.selectedObject,
                        selectedType: $floorPlanViewModel.selectedType)
                    .frame(height: 200)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(5)
            }
            
            if viewModel.isShowingFloorPlan,
               floorPlanViewModel.selectedObject == nil, 
               floorPlanViewModel.selectedSurface == nil,
               floorPlanViewModel.selectedAnnotation == nil,
               !floorPlanViewModel.shouldAddFurniture,
               floorPlanViewModel.roomOptionType != .exportImage {
                
                VStack {
                    Spacer()
                    RoomOptionsView(
                        selectedOption: $floorPlanViewModel.roomOptionType,
                        shouldAddFurniture: $floorPlanViewModel.shouldAddFurniture,
                        shouldAddText: $floorPlanViewModel.shouldAddText,
                        shouldShareImage: $floorPlanViewModel.shouldShareImage)
                    .frame(height: 120)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(4)
            }
            
            if floorPlanViewModel.selectedAnnotation != nil {
                VStack {
                    Spacer()
                    AnnotationsDetailsView(selectedAnnotation: $floorPlanViewModel.selectedAnnotation)
                        .frame(height: 250)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(5)
            }
            
            // Replaced .sheet with floating panels
            if floorPlanViewModel.selectedSurface != nil {
                VStack {
                    Spacer()
                    SurfaceDetailsView(
                        surface: $floorPlanViewModel.selectedSurface,
                        selectedType: $floorPlanViewModel.selectedType)
                    .frame(height: 220)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(6)
            }
            
            if floorPlanViewModel.roomOptionType == .exportImage {
                VStack {
                    Spacer()
                    ShareImageView(
                        shouldShareImage: $floorPlanViewModel.shouldShareImage,
                        shareFormat: $floorPlanViewModel.shareFormat,
                        roomOptionType: $floorPlanViewModel.roomOptionType)
                    .frame(height: 250)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(7)
            }
            
            if floorPlanViewModel.shouldAddFurniture {
                VStack {
                    Spacer()
                    AddFurnitureView(floorPlanViewModel: floorPlanViewModel)
                    .frame(height: 300)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .zIndex(8)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: floorPlanViewModel.selectedObject != nil)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: floorPlanViewModel.selectedSurface != nil)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: floorPlanViewModel.selectedAnnotation != nil)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: floorPlanViewModel.shouldAddFurniture)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: floorPlanViewModel.roomOptionType)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: viewModel.isShowingFloorPlan)
        .onAppear {
            if !isDemo {
                viewModel.startSession()
            }
        }
        .alert("Error", isPresented: $viewModel.isShowError, actions: {
            Button("OK", role: .cancel) {}
        }, message: {
            Text(viewModel.errorMessage)
        })
        .navigationBarHidden(true) // Hide native nav bar so our floating UI works
    }
}

// MARK: Views
private extension RoomCaptureScanView {
    
    @ViewBuilder
    var mainRoomView: some View {
        if isDemo {
            if let finalRoom = mockDataManager.loadCapturedRoom() {
                FloorPlanSceneView(capturedRoom: finalRoom,
                                   viewModel: floorPlanViewModel)
                .ignoresSafeArea()
            }
        } else {
            if viewModel.isShowingFloorPlan,
               let finalRoom = viewModel.getFinalRoom() {
                FloorPlanSceneView(capturedRoom: finalRoom,
                                   viewModel: floorPlanViewModel)
                .ignoresSafeArea()
            } else {
                RoomCaptureRepresentable(roomCaptureView: viewModel.roomCaptureView)
                    .ignoresSafeArea()
            }
        }
    }
    
    var topFloatingToolbar: some View {
        HStack(spacing: 12) {
            if !viewModel.isScanning {
                Button(action: {
                    withAnimation { viewModel.shareCapturedRoom() }
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            
            Button(action: {
                withAnimation { viewModel.handleScanButtonTap() }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: viewModel.isScanning ? "stop.circle.fill" : "checkmark.circle.fill")
                    Text(viewModel.isScanning ? "Finish Scanning" : "View 2D Plan")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(viewModel.isScanning ? .red : .white)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(viewModel.isScanning ? Color.red.opacity(0.2) : Color.white.opacity(0.2))
                .clipShape(Capsule())
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.white.opacity(0.3), lineWidth: 1))
        .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    RoomCaptureScanView()
}
