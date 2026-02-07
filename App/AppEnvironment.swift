//
//  AppEnvironment.swift
//  PedalPal
//
//  Created by Alvaro Cascante Retana on 3/2/26.
//

import Foundation
import Combine

@MainActor
final class AppEnvironment: ObservableObject {
    let authRepository: AuthRepository
    
    init() {
        let firebaseDS = FirebaseAuthDataSourceImpl()
        let remoteDS = AuthRemoteDataSourceImpl(baseURL: "https://api.pedalpal.com")

        self.authRepository = AuthRepositoryImpl(
            remote: remoteDS,
            firebase: firebaseDS
        )
        
    }
}

extension AppEnvironment {
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            useCases: LoginUseCases(
                checkEmailVerified: CheckEmailVerifiedUseCase(authRepository: authRepository),
                sendVerificationEmail: SendVerificationEmailUseCase(authRepository: authRepository),
                signInWithEmail: SignInWithEmailUseCase(authRepository: authRepository),
                signInWithGoogle: SignInWithGoogleUseCase(authRepository: authRepository),
                signUpWithEmail: SignUpWithEmailUseCase(authRepository: authRepository),
                reloadUser: ReloadUserUseCase(authRepository: authRepository),
            )
        )
    }
}
