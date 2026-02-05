import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Home")
                .font(.largeTitle)
                .bold()

            NavigationLink("Go to details") {
                VStack {
                    Text("Home Details")
                    Text("This is a placeholder detail view for Home tab.")
                }
                .navigationTitle("Home Details")
                .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Home")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
