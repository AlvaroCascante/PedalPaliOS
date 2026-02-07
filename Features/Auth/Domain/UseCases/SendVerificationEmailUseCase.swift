import Foundation

public struct SendVerificationEmailUseCase {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute() async throws {
        try await authRepository.sendEmailVerification()
    }
}
