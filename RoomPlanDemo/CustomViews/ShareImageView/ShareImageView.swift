//
//  ShareImageView.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 14.08.2026.
//

import SwiftUI

struct ShareImageView: View {
    @Binding private var shouldShareImage: Bool
    @Binding private var shareFormat: ImageFormat?
    @Binding private var roomOptionType: RoomOptionType?
    
    @State var selectedOption: ImageFormat = .png
    
    init(shouldShareImage: Binding<Bool>,
         shareFormat: Binding<ImageFormat?>,
         roomOptionType: Binding<RoomOptionType?>) {
        _shouldShareImage = shouldShareImage
        _shareFormat = shareFormat
        _roomOptionType = roomOptionType
    }
    
    var body: some View {
        contentView
    }
}

// MARK: Views
private extension ShareImageView {
    var contentView: some View {
        VStack(spacing: 20) {
            header
            
            allFormatButtons
            
            exportButton
            
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
    
    var allFormatButtons: some View {
        HStack(spacing: 12) {
            ForEach(ImageFormat.allCases, id: \.self) { option in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        selectFormat(option)
                    }
                } label: {
                    Text(option.descriptionFormat)
                        .foregroundStyle(selectedOption == option ? Color.white : Color.primary)
                        .font(.headline)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? Color.blue : Color.primary.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                        )
                        .shadow(color: selectedOption == option ? Color.blue.opacity(0.3) : .clear, radius: 8, x: 0, y: 4)
                        .tag(option)
                }
            }
        }
    }
    
    var exportButton: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                exportImage()
            }
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "square.and.arrow.up.fill")
                    .font(.headline)
                Text("Export")
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.blue.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
    
    var header: some View {
        HStack {
            Text("Export Format")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Spacer()
            
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    closeView()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.secondary, Color.primary.opacity(0.1))
            }
        }
    }
}

// MARK: Action
private extension ShareImageView {
    func closeView() {
        shareFormat = nil
        shouldShareImage = false
        roomOptionType = nil
    }
    
    func exportImage() {
        shareFormat = selectedOption
        shouldShareImage = false
        roomOptionType = nil
    }
    
    func selectFormat(_ option: ImageFormat) {
        selectedOption = option
    }
}

#Preview {
    ShareImageView(shouldShareImage: .constant(true),
                   shareFormat: .constant(.jpeg),
                   roomOptionType: .constant(nil))
}
