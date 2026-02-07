//
//  FirebaseUser+Async.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//
import FirebaseAuth

extension User {

    func reloadAsync() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.reload { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }

    func getIDTokenResultAsync(forceRefresh: Bool) async throws -> AuthTokenResult {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<AuthTokenResult, Error>) in
            self.getIDTokenResult(forcingRefresh: forceRefresh) { result, error in
                if let error {
                    continuation.resume(throwing: error)
                } else if let result {
                    continuation.resume(returning: result)
                } else {
                    continuation.resume(throwing: AuthError.idTokenNil)
                }
            }
        }
    }

    func sendEmailVerificationAsync() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            self.sendEmailVerification { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
}
