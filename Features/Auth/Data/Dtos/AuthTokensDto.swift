//
//  AuthTokensDto.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

struct AuthTokensDto: Decodable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int64
}
