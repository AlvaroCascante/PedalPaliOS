import Foundation

public struct CheckEmailVerifiedUseCase {
    private let authRepository: AuthRepository

    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func execute() async -> Bool {
        await authRepository.isEmailVerified()
    }
}
