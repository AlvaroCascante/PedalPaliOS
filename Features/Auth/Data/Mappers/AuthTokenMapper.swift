//
//  AuthTokensMapper.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//
struct AuthTokenMapper {
    static func toDomain(_ dto: AuthTokensDto) -> AuthToken {
        AuthToken(
            accessToken: dto.accessToken,
            refreshToken: dto.refreshToken,
            expiresIn: dto.expiresIn
        )
    }
}
