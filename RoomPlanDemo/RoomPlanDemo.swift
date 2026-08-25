//
//  RoomPlanDemo.swift
//  DesignerX
//
//  Created by Aditya Sontakke on 17.08.2026.
//

import SwiftUI

@main
struct DesignerXApp: App {
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(appTheme.colorScheme)
        }
    }
}
