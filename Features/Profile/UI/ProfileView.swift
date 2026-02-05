import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Profile")
                .font(.largeTitle)
                .bold()

            NavigationLink("Edit profile") {
                VStack {
                    Text("Edit Profile")
                    Text("This is a placeholder edit screen for Profile tab.")
                }
                .navigationTitle("Edit Profile")
                .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }
    }
}
