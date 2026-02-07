//
//  AuthRemoteDataSource.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

protocol AuthRemoteDataSource {
    func createUser(
        request: BackendCreateUserRequest,
        firebaseIdToken: String
    ) async throws -> AuthToken
}
