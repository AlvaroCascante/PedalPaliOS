import Foundation

// Bundle of login-related use cases to simplify ViewModel injection
struct LoginUseCases {
    let checkEmailVerified: CheckEmailVerifiedUseCase
    let sendVerificationEmail: SendVerificationEmailUseCase
    let signInWithEmail: SignInWithEmailUseCase
    let signInWithGoogle: SignInWithGoogleUseCase
    let signUpWithEmail: SignUpWithEmailUseCase
    let reloadUser: ReloadUserUseCase
}
