import Foundation

public struct SignUpWithEmailUseCase {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute(email: String, password: String) async throws -> FirebaseUserInfo {
        try await authRepository.signUpWithEmail(email: email, password: password)
    }
}
