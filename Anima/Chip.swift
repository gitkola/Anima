import SwiftUI

struct Chip: View {
    public var image: String = "chip1"
    public var offsetX: Double = 0
    public var offsetY: Double = 0
    public var offsetValue: Double = 0
    public var duration: Double = 2
    @State private var offset: Double = 0
    var body: some View {
        Image(image)
            .clipShape(.circle)
            .offset(x: offsetX * offset, y: offsetY * offset)
            .animation(Animation.linear(duration: duration).repeatForever(autoreverses: true), value: offset)
            .onAppear {
                offset = offsetValue
            }
    }
}

#Preview {
    Chip(image: "chip2", offsetX: -20, offsetY: -20, offsetValue: 1.1, duration: 1.5)
        .shadow(color: Color(red: 255/255, green: 233/255, blue: 78/255), radius: 10)
        .blur(radius: 1)
        .position(CGPoint(x: 100.0, y: 100.0))
}
