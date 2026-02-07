//
//  AuthRemoteDataSourceImpl.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

final class AuthRemoteDataSourceImpl: AuthRemoteDataSource {

    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func createUser(
        request: BackendCreateUserRequest,
        firebaseIdToken: String
    ) async throws -> AuthToken {

        // 🔧 Mocked response for now
        let dto = AuthTokensDto(
            accessToken: "eyJraWQiOiJ1c2VyLXNlcnZpY2Uta2V5LWlkLTIwMjYtMDEiLCJhbGciOiJSUzI1NiJ9....",
            refreshToken: "eyJraWQiOiJ1c2VyLXNlcnZpY2Uta2V5LWlkLTIwMjYtMDEiLCJhbGciOiJSUzI1NiJ9....",
            expiresIn: 3600
        )

        return AuthTokenMapper.toDomain(dto)
    }
}
