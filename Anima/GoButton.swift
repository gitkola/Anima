import SwiftUI


struct GoButton: View {
    public var action: () -> Void
    @State private var size: CGSize = .zero
    @State private var isPressed = false
    var body: some View {
            ZStack {
                GeometryReader { geometry in
                    Button(action: {
                        action()
                    }) {
                        ZStack {
                            GoButtonShape()
                                .foregroundColor(.white)
                                .frame(height: 60)
                                .background(
                                    GeometryReader { btnGeometry in
                                        Color.clear
                                            .onAppear {
                                                size = geometry.size
                                            }
                                    }
                                )
                            HStack{
                                Text("GO MAKE YOUR BET")
                                    .font(Font.custom("Goldman-Regular", size: geometry.size.width * 0.046))
                                    .foregroundColor(Color(red: 236/255, green: 35/255, blue: 87/255))
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.white)
                                    .scaleEffect(CGSize(width: 2, height: 2))
                                    .frame(width: geometry.size.width * 0.11, height: geometry.size.width * 0.13, alignment: .trailing)
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
                                    .background(
                                        GoButtonArrowBackgroundShape()
                                            .foregroundColor(Color(red: 236/255, green: 35/255, blue: 87/255))
                                    )
                            }
                            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 16))
                        }
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .local)
                            .onChanged({_ in
                                isPressed = true
                            }).onEnded({_ in
                                isPressed = false
                            })
                    )
                    .scaleEffect(isPressed ? 0.95 : 1.0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.5, blendDuration: 0), value: isPressed)
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                    .opacity(1.0)
                }
                .frame(height: .leastNonzeroMagnitude)
            }
    }
}




#Preview {
    ZStack {
        Background()
        GoButton {
            print("Button was tapped!")
        }
    }
}



struct GoButtonShape: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.height * 0.1, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.width * 0.92, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.98, y: rect.height * 0.2 ), control: CGPoint(x: rect.width * 0.965, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.width * 0.992, y: rect.height * 0.38))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.992, y: rect.height * 0.62), control: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: rect.height * 0.8))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.92, y: rect.maxY), control: CGPoint(x: rect.width * 0.965, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX * 0.1, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.midY * 1.5), control: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY * 0.5))
        path.addQuadCurve(to: CGPoint(x: rect.midX * 0.1, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        
        return path
    }
}



struct GoButtonArrowBackgroundShape: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.width * 0.25, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.width * 0.7, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.92, y: rect.height * 0.2), control: CGPoint(x: rect.width * 0.86, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.width * 0.98, y: rect.midY * 0.8))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.98, y: rect.midY * 1.2), control: CGPoint(x: rect.width, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width * 0.92, y: rect.height * 0.8))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.7, y: rect.height), control: CGPoint(x: rect.width * 0.86, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.width * 0.25, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.height * 0.6), control: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height * 0.4))
        path.addQuadCurve(to: CGPoint(x: rect.width * 0.25, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}
