//
//  FirebaseAuth+Async.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//
import FirebaseAuth

extension Auth {

    func signInAsync(
        withEmail email: String,
        password: String
    ) async throws -> AuthDataResult {
        try await withCheckedThrowingContinuation { continuation in
            signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                }
            }
        }
    }

    func signInAsync(
        with credential: AuthCredential
    ) async throws -> AuthDataResult {
        try await withCheckedThrowingContinuation { continuation in
            signIn(with: credential) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                }
            }
        }
    }

    func createUserAsync(
        withEmail email: String,
        password: String
    ) async throws -> AuthDataResult {
        try await withCheckedThrowingContinuation { continuation in
            createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let result = result {
                    continuation.resume(returning: result)
                }
            }
        }
    }
}
