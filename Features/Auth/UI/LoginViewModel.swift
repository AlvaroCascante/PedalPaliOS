import Foundation
import Combine
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

@MainActor
final class LoginViewModel: ObservableObject {

    // MARK: - Published UI State
    @Published private(set) var uiState = LoginUiState()

    private let useCases: LoginUseCases

    // MARK: - UI Events
    enum LoginUiEvent {
        case navigateHome
        case navigateCompleteProfile
        case showError(String)
    }
    let uiEvents = PassthroughSubject<LoginUiEvent, Never>()

    // MARK: - Init
    init(useCases: LoginUseCases) {
        self.useCases = useCases
    }

    // MARK: - Input Handlers

    func onEmailChanged(_ email: String) {
        uiState.email = email
    }

    func onPasswordChanged(_ password: String) {
        uiState.password = password
    }

    func onContinueWithEmailSubmit() {
        guard !uiState.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !uiState.password.isEmpty else {
            uiEvents.send(.showError("Please enter email and password."))
            return
        }

        Task { await signInWithEmail() }
    }

    func onSignUpWithEmail() {
        guard !uiState.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !uiState.password.isEmpty else {
            uiEvents.send(.showError("Please enter email and password."))
            return
        }

        Task { await signUpWithEmail() }
    }

    func onGoogleIntentRequested() {
        Task { await handleGoogleSignIn() }
    }

    func onGoogleSignInFailed(_ reason: String) {
        uiEvents.send(.showError(reason))
    }

    func onCheckEmailVerified() {
        Task { await checkEmailVerified() }
    }

    func onResendVerificationEmail() {
        Task { await resendVerificationEmail() }
    }

    func onNavigateHome() {
        uiState.isLoggedIn = true
    }

    func onProfileCompleted() {
        uiState.isProfileComplete = true
    }

    // MARK: - Private Async Handlers

    private func signInWithEmail() async {
        uiState.isLoading = true
        defer { uiState.isLoading = false }

        do {
            let user = try await useCases.signInWithEmail.execute(
                email: uiState.email,
                password: uiState.password
            )
            uiState.currentUser = user

            let verified = (try? await useCases.checkEmailVerified.execute()) ?? false
            if verified {
                uiState.isLoggedIn = true
                uiEvents.send(.navigateCompleteProfile)
            } else {
                try? await useCases.sendVerificationEmail.execute()
                uiState.isEmailVerificationSent = true
            }
        } catch {
            handleError(error)
        }
    }

    private func signUpWithEmail() async {
        uiState.isLoading = true
        defer { uiState.isLoading = false }

        do {
            let user = try await useCases.signUpWithEmail.execute(
                email: uiState.email,
                password: uiState.password
            )
            uiState.currentUser = user

            // Send verification email (best effort)
            try? await useCases.sendVerificationEmail.execute()
            uiState.isEmailVerificationSent = true
        } catch {
            handleError(error)
        }
    }

    private func handleGoogleSignIn() async {
        uiState.isLoading = true
        defer { uiState.isLoading = false }

        do {
            let idToken = try await getGoogleIdToken()
            let user = try await useCases.signInWithGoogle.execute(idToken: idToken)
            uiState.currentUser = user
            uiEvents.send(.navigateCompleteProfile)
        } catch {
            handleError(error)
        }
    }

    private func checkEmailVerified() async {
        uiState.isLoading = true
        defer { uiState.isLoading = false }

        do {
            if uiState.currentUser != nil {
                _ = try? await useCases.reloadUser.execute()
            }

            let verified = try await useCases.checkEmailVerified.execute()
            if verified {
                uiState.isLoggedIn = true
                uiEvents.send(.navigateCompleteProfile)
            } else {
                uiEvents.send(.showError("Email not verified yet."))
            }
        } catch {
            handleError(error)
        }
    }

    private func resendVerificationEmail() async {
        uiState.isLoading = true
        defer { uiState.isLoading = false }

        do {
            try await useCases.sendVerificationEmail.execute()
            uiState.isEmailVerificationSent = true
            uiEvents.send(.showError("Verification email sent. Check your inbox."))
        } catch {
            handleError(error)
        }
    }

    // MARK: - Helpers

    private func handleError(_ error: Error) {
        let message = (error as NSError).localizedDescription
        uiState.errorMessage = message
        uiEvents.send(.showError(message))
    }

    /// Stub: replace with actual Google Sign-In SDK async call
    private func getGoogleIdToken() async throws -> String {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            throw NSError(
                domain: "GoogleSignIn",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "No root view controller"]
            )
        }

        let result = try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootVC
        )

        guard let idToken = result.user.idToken?.tokenString else {
            throw NSError(
                domain: "GoogleSignIn",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Missing Google ID token"]
            )
        }

        return idToken
    }
}
