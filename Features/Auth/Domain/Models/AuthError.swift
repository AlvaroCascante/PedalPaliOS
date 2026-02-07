//
//  AuthError.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

enum AuthError: Error {
    case noCurrentUser
    case idTokenNil
    case userNilAfterSignIn
    case userNilAfterSignUp
}
