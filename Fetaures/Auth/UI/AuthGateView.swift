import SwiftUI

/// Auth gate view chooses between login, profile completion or main app flow.
struct AuthGateView: View {
    @StateObject private var viewModel = AuthGateViewModel()

    var body: some View {
        Group {
            if viewModel.isLoggedIn {
                // If profile completion is needed you could check viewModel.isProfileComplete
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

// MARK: - Lightweight stubs
// If your project already has `LoginView` and `MainTabView`, these will be unused.
private struct LoginView: View {
    var body: some View {
        Text("Login View Placeholder")
            .padding()
    }
}

private struct MainTabView: View {
    var body: some View {
        Text("Main Tab View Placeholder")
            .padding()
    }
}

// MARK: - Previews
struct AuthGateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthGateView()
    }
}
