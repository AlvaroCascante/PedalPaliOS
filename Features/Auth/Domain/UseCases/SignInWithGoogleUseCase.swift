import Foundation

public struct SignInWithGoogleUseCase {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute(idToken: String) async throws -> FirebaseUserInfo {
        try await authRepository.signInWithGoogle(googleIdToken: idToken)
    }
}
