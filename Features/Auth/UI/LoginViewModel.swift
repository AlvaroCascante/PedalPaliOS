import Foundation
import Combine

/// Minimal LoginViewModel that owns `LoginUiState` and exposes actions.
/// Replace simulated implementations with real repositories / use-cases.
final class LoginViewModel: ObservableObject {
    // Published ui state the view observes
    @Published private(set) var uiState = LoginUiState()
    @Published var isLoggedIn: Bool = false
    @Published var isProfileComplete: Bool = false
    
    // UI events stream for one-off navigation or error messages
    enum LoginUiEvent {
        case navigateHome
        case navigateCompleteProfile
        case showError(String)
    }

    let uiEvents = PassthroughSubject<LoginUiEvent, Never>()

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.isLoggedIn = false
        self.isProfileComplete = false
    }

    // MARK: - Input handlers (called from the view)

    func onEmailChanged(_ email: String) {
        uiState.email = email
    }

    func onPasswordChanged(_ password: String) {
        uiState.password = password
    }

    func onContinueWithEmailSubmit() {
        // Validate
        guard !uiState.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !uiState.password.isEmpty else {
            uiEvents.send(.showError("Please enter email and password."))
            return
        }

        uiState.isLoading = true

        // Simulate network call - replace with real auth call
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.9) { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.uiState.isLoading = false

                if self.uiState.email.lowercased().contains("verify") {
                    self.uiState.isEmailVerificationSent = true
                } else {
                    // Successful login -> navigate home
                    self.uiEvents.send(.navigateHome)
                }
            }
        }
    }

    func onGoogleIntentRequested() -> Void {
        // In iOS you would return a configured sign-in flow / request. Keep stubbed.
    }

    func onGoogleIdTokenReceived(_ token: String) {
        // Handle id token with your backend
        uiEvents.send(.navigateHome)
    }

    func onGoogleSignInFailed(_ reason: String) {
        uiEvents.send(.showError(reason))
    }

    func onCheckEmailVerified() {
        // Replace with backend check; here we simulate success
        uiEvents.send(.navigateHome)
    }

    func onResendVerificationEmail() {
        // Simulate resend
        uiEvents.send(.showError("Verification email sent. Check your inbox."))
    }
}
