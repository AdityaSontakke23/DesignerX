import SwiftUI

struct DotGrid: Shape {
    var step: CGFloat = 20
    var dotSize: CGFloat = 2
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for x in stride(from: 0, to: rect.width, by: step) {
            for y in stride(from: 0, to: rect.height, by: step) {
                let pointRect = CGRect(x: x, y: y, width: dotSize, height: dotSize)
                path.addEllipse(in: pointRect)
            }
        }
        
        return path
    }
}

struct DashboardView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Pattern Background
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea()
                
                DotGrid(step: 25, dotSize: 3)
                    .fill(Color.primary.opacity(0.05))
                    .ignoresSafeArea()
                
                // MARK: - Ambient Glow Animation
                GeometryReader { geo in
                    ZStack {
                        Circle()
                            .fill(Color.indigo.opacity(0.4))
                            .frame(width: geo.size.width * 0.8)
                            .offset(x: isAnimating ? geo.size.width * 0.2 : -geo.size.width * 0.2,
                                    y: isAnimating ? -geo.size.height * 0.2 : geo.size.height * 0.2)
                            .blur(radius: 60)
                        
                        Circle()
                            .fill(Color.purple.opacity(0.4))
                            .frame(width: geo.size.width * 0.7)
                            .offset(x: isAnimating ? -geo.size.width * 0.3 : geo.size.width * 0.3,
                                    y: isAnimating ? geo.size.height * 0.3 : -geo.size.height * 0.1)
                            .blur(radius: 60)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 8).repeatForever(autoreverses: true), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // MARK: - Header
                    VStack(spacing: 16) {
                        Image(systemName: "square.3.layers.3d.down.left")
                            .font(.system(size: 80, weight: .light))
                            .foregroundStyle(.primary)
                        
                        Text("DesignerX")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundStyle(.primary)
                            .tracking(2)
                        
                        Text("Transform your physical space into an interactive 2D blueprint in seconds.")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    Spacer()
                    
                    // MARK: - Action Buttons
                    VStack(spacing: 20) {
                        NavigationLink(destination: RoomCaptureScanView()) {
                            HStack(spacing: 15) {
                                Image(systemName: "camera.viewfinder")
                                    .font(.title2)
                                Text("Start Scanning")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .foregroundStyle(Color.white)
                            .background(Color.indigo.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .shadow(color: Color.indigo.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        
                        NavigationLink(destination: RoomCaptureScanView(isDemo: true)) {
                            HStack(spacing: 15) {
                                Image(systemName: "play.circle.fill")
                                    .font(.title2)
                                Text("Try Demo Mode")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .foregroundStyle(.primary)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24, style: .continuous)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
