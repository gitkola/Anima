import SwiftUI

@main
struct AnimaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


extension String {
    func failureColor() -> String {
        return Array(self).map({ "\($0)\u{fe06}"}).joined()
    }
    
    func successColor() -> String {
        return Array(self).map({ "\($0)\u{fe07}"}).joined()
    }
    
    func warningColor() -> String {
        return Array(self).map({ "\($0)\u{fe08}"}).joined()
    }
}
