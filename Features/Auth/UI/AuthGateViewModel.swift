import Foundation
import Combine

/// Simple view model for the Auth gate. Replace the login simulation with your auth repo later.
final class AuthGateViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isProfileComplete: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Replace with real auth state publisher from your auth layer.
        // For now we simulate an unauthenticated user. You can toggle these values
        // in previews or during development.
        self.isLoggedIn = false
        self.isProfileComplete = false
    }
}
