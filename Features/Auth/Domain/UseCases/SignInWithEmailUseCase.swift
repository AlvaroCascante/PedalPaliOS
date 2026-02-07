import Foundation

public struct SignInWithEmailUseCase {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute(email: String, password: String) async throws -> FirebaseUserInfo {
        try await authRepository.signInWithEmail(email: email, password: password)
    }
}
