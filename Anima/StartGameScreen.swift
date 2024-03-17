import SwiftUI

struct StartGameScreen: View {
    @State private var navigate = false
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Background()
                    VStack {
                        SpinTable()
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - geometry.size.width / 4 * 0.8)
                            .shadow(color: .black.opacity(0.45), radius: 15, x: 5, y: 15)
                        GoButton {
                            print("Button was pressed!")
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                            self.navigate = true
                        }
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 5, y: 15)
                        .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.24)
                        .background(
                            NavigationLink(destination: DetailsView(), isActive: $navigate) {
                                EmptyView()
                            }
                            .hidden()
                        )
                    }
                    Chip(image: "chip1", offsetX: -2, offsetY: -10, offsetValue: 1.1, duration: 1.3)
                        .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.1)
                        .shadow(color: Color(red: 96/255, green: 244/255, blue: 255/255), radius: 10)
                        .blur(radius: 1)
                    Chip(image: "chip2", offsetX: 8, offsetY: -10, offsetValue: 1.5, duration: 2.3)
                        .position(x: geometry.size.width * 0.75, y: geometry.size.height * 0.16)
                        .shadow(color: Color(red: 255/255, green: 233/255, blue: 78/255), radius: 10)
                        .blur(radius: 2)
                    Chip(image: "chip3", offsetX: -8, offsetY: -10, offsetValue: 1.8, duration: 1.8)
                        .position(x: geometry.size.width * 0.15, y: geometry.size.height * 0.71)
                        .shadow(color: Color(red: 229/255, green: 186/255, blue: 229/255), radius: 10)
                        .shadow(color: Color(red: 0/255, green: 0/255, blue: 0/255, opacity: 0.5), radius: 5)
                    Chip(image: "chip4", offsetX: 6, offsetY: -6, offsetValue: 1.2, duration: 2.0)
                        .position(x: geometry.size.width * 0.8, y: geometry.size.height * 0.9)
                        .shadow(color: Color(red: 78/255, green: 217/255, blue: 71/255), radius: 10)
                        .blur(radius: 3)
                }
                .ignoresSafeArea(.all)
            }
            .ignoresSafeArea(.all)
        }
    }
}

//#Preview {
//    StartGameScreen()
//}
