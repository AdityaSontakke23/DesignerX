//
//  RoomCaptureRepresentable.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 15.08.2026.
//

import RoomPlan
import SwiftUI

struct RoomCaptureRepresentable: UIViewRepresentable {
    private let roomCaptureView: RoomCaptureView

    
    init(roomCaptureView: RoomCaptureView) {
        self.roomCaptureView = roomCaptureView
    }
    
    func makeUIView(context: Context) -> RoomCaptureView {
        return roomCaptureView
    }
    
    func updateUIView(_ uiView: RoomCaptureView, context: Context) {
    }
}
