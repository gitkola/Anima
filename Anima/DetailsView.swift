import SwiftUI

struct DetailsView: View {
    var body: some View {
        ZStack {
            Text("This is the detail view")
                .navigationBarTitle("Detail", displayMode: .inline)
        }
    }
}

#Preview {
    DetailsView()
}
