import SwiftUI

struct SettingsView: View {
    @AppStorage("appTheme") private var appTheme: AppTheme = .system
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $appTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Export Defaults")) {
                    HStack {
                        Text("Default Format")
                        Spacer()
                        Text("USDZ")
                            .foregroundStyle(.secondary)
                    }
                    Toggle("Include Floor Plan Annotations", isOn: .constant(true))
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Aditya Sontakke")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
