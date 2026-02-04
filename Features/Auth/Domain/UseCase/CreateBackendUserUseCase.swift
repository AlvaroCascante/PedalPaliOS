import Foundation

public struct CreateBackendUserUseCase {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute(request: BackendCreateUserRequest) async throws -> AuthToken {
        let idToken = try await authRepository.getFirebaseIdToken(forceRefresh: true)
        return try await authRepository.createBackendUser(request: request, firebaseIdToken: idToken)
    }
}
