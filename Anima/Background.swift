import SwiftUI

struct Background: View {
    @State private var wheelRotation: Double = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [
                        Color(red: 238/255, green: 83/255, blue: 141/255),
                        Color(red: 59/255, green: 169/255, blue: 254/255)
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: geometry.size.height * 0.9
                )
                .transformEffect(.init(scaleX: 0.5, y: 1.0))
                .position(x: geometry.size.width * 1.5, y: geometry.size.height)
                .frame(width: geometry.size.width * 2, height: geometry.size.height * 2)
                .animation(Animation.linear(duration: 15).repeatForever(autoreverses: false), value: wheelRotation)
                .ignoresSafeArea(.all)
                
                Circle()
                    .fill(Color(red: 234/255, green: 60/255, blue: 165/255))
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .blur(radius: geometry.size.width / 10)
                    .position(x: geometry.size.width, y: geometry.size.height - geometry.size.width / 4 * 0.8)
                    
                    
            }
            .ignoresSafeArea(.all)
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    Background()
}
