//
//  FirebaseAuthDataSource.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 5/2/26.
//

protocol FirebaseAuthDataSource {
    func getCurrentUserInfo() async throws -> FirebaseUserInfo?
    func getIdToken(forceRefresh: Bool) async throws -> String
    func isEmailVerified() async throws -> Bool
    func reloadUser() async throws
    func sendEmailVerification() async throws
    func signInWithEmail(email: String, password: String) async throws -> FirebaseUserInfo
    func signInWithGoogle(googleIdToken: String) async throws -> FirebaseUserInfo
    func signUpWithEmail(email: String, password: String) async throws -> FirebaseUserInfo
}
