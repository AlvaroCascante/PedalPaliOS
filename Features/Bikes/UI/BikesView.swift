import SwiftUI

struct BikesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Bikes")
                .font(.largeTitle)
                .bold()

            NavigationLink("View bike") {
                VStack {
                    Text("Bike Details")
                    Text("This is a placeholder detail view for Bikes tab.")
                }
                .navigationTitle("Bike Details")
                .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Bikes")
    }
}

struct BikesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BikesView()
        }
    }
}
