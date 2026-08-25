//
//  AnnotationsDetailsView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 15.08.2026.
//

import SwiftUI
import SpriteKit

struct AnnotationsDetailsView: View {
    @Binding private var selectedAnnotation: FloorPlanAnnotation?
    
    @State private var newTitle = ""
    @State private var isEditingTitle = false
    @State private var isEditingSubTitle = false
    @State private var angle: CGFloat = 0
    
    let mainActions: [DetailsType] = [.rotate, .delete]
    
    init(selectedAnnotation: Binding<FloorPlanAnnotation?>) {
        _selectedAnnotation = selectedAnnotation
    }
    
    var body: some View {
        VStack(spacing: 10) {
            headerView
            
            ScrollView {
                VStack(spacing: 10) {
                    mainActionButtonView
                    
                    updateColorView
                }
            }
            
            Spacer()
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
        .alert("Edit Annotation Title", isPresented: $isEditingTitle, actions: {
            TextField("New Title", text: $newTitle)
            Button("Save") {
                selectedAnnotation?.updateTitle(newTitle)
            }
            Button("Cancel", role: .cancel) {}
        })
        .alert("Edit Annotation SubTitle", isPresented: $isEditingSubTitle, actions: {
            TextField("New SubTitle", text: $newTitle)
            Button("Save") {
                selectedAnnotation?.updateSubTitle(newTitle)
            }
            Button("Cancel", role: .cancel) {}
        })
        .onAppear {
            if let selectedAnnotation {
                angle = selectedAnnotation.zRotation
            }
        }
    }
}

// MARK: Views
private extension AnnotationsDetailsView {
    func editLabelView(isEditingTitleLabel: Bool) -> some View {
        Button {
            withAnimation {
                editAnnotation(isEditingTitleLabel: isEditingTitleLabel)
            }
        } label: {
            HStack {
                let labelText = isEditingTitleLabel ? selectedAnnotation?.titleLabel.text : selectedAnnotation?.subtitleLabel.text
                Text(labelText ?? "No Annotation Selected")
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Image(systemName: "pencil")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
            .background(Color.primary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
            )
        }
    }
    
    var closeButton: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                closeView()
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(.secondary, Color.primary.opacity(0.1))
        }
    }
    
    var headerView: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                editLabelView(isEditingTitleLabel: true)
                editLabelView(isEditingTitleLabel: false)
            }
            Spacer()
            closeButton
        }
    }
    
    var mainActionButtonView: some View {
        HStack(spacing: 20) {
            ForEach(mainActions, id: \.self) { option in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                        action(for: option)
                    }
                } label: {
                    VStack(spacing: 8) {
                        Image(systemName: option.buttonImageName)
                            .font(.title2)
                            .foregroundStyle(option == .delete ? .red : .blue)
                            .frame(width: 50, height: 50)
                            .background(option == .delete ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                            .clipShape(Circle())
                        
                        Text(option.description)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary.opacity(0.8))
                    }
                }
            }
        }
        .padding(.vertical, 5)
    }
    
    var updateColorView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Update Annotation Color")
                .font(.headline)
                .foregroundStyle(.primary)
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(MainColor.allCases, id: \.self) { color in
                        Button {
                            withAnimation {
                                updateColor(color)
                            }
                        } label: {
                            Circle()
                                .fill(color.color)
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: Actions
private extension AnnotationsDetailsView {
    func closeView() {
        selectedAnnotation?.removeHighlight()
        selectedAnnotation = nil
    }
    
    func editAnnotation(isEditingTitleLabel: Bool) {
        if isEditingTitleLabel {
            newTitle = selectedAnnotation?.titleLabel.text ?? ""
            isEditingTitle = true
        } else {
            newTitle = selectedAnnotation?.subtitleLabel.text ?? ""
            isEditingSubTitle = true
        }
    }
    
    func action(for type: DetailsType) {
        switch type {
        case .delete:
            selectedAnnotation?.removeFromParent()
            selectedAnnotation = nil
        case .rotate:
            // Increment the angle by 15 degrees
            let incrementedAngle = angle + 15
            
            // Snap the angle to the nearest 15 degrees (although this may not be necessary since increments are already 15)
            let snappedAngle = round(incrementedAngle / 15) * 15
            
            // Normalize the angle to keep it within 0–360 degrees
            let normalizedAngle = snappedAngle.truncatingRemainder(dividingBy: 360)
            
            // Update the annotation's angle
            selectedAnnotation?.updateAngle(to: normalizedAngle)
            
            // Update the local angle variable
            angle = normalizedAngle
        default: break
        }
    }
    
    func updateColor(_ color: MainColor) {
        selectedAnnotation?.updateColor(color.skColor)
    }
}

#Preview {
    AnnotationsDetailsView(selectedAnnotation: .constant(nil))
}
