import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Scanner", systemImage: "square.3.layers.3d.down.left")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .tint(.indigo)
    }
}

#Preview {
    MainTabView()
}
