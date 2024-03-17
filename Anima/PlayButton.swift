import SwiftUI

struct PlayButton: View {
    public var action: () -> Void
    @State private var size: CGSize = .zero
    @State private var isPressed = false
    var body: some View {
        PlayButtonShape()
            .fill(Color.blue)
            .frame(width: 300, height: 300)
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 0))
            .previewLayout(.sizeThatFits)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({_ in
                        isPressed = true
                    }).onEnded({_ in
                        isPressed = false
                    })
            )
            .rotationEffect(isPressed ? Angle(degrees: 90) : Angle(degrees: 0))
            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0), value: isPressed)
            .scaleEffect(isPressed ? 0.8 : 1.0)
            .animation(.spring(response: 0.35, dampingFraction: 0.5, blendDuration: 0), value: isPressed)
    }
}

struct PlayButtonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.midY * 0.4))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 1.6))
        path.addQuadCurve(to: CGPoint(x: rect.midX * 0.5, y: rect.midY * 1.9),
                          control: CGPoint(x: rect.minX, y: rect.midY * 2.2))
        path.addLine(to: CGPoint(x: rect.midX*1.6, y: rect.midY * 1.25))
        path.addQuadCurve(to: CGPoint(x: rect.midX*1.6, y: rect.midY * 0.75 ),
                          control: CGPoint(x: rect.midX * 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX * 0.5, y: rect.midY * 0.1))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY * 0.4 ),
                          control: CGPoint(x: rect.minX, y: -rect.midY * 0.2))

        return path
    }
}



#Preview {
    PlayButton {
        print("Play")
    }
}
