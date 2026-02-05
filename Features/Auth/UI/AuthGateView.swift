import SwiftUI

/// Auth gate view chooses between login, profile completion or main app flow.
struct AuthGateView: View {
    @StateObject private var loginViewModel = LoginViewModel()

    var body: some View {
        Group {
            if loginViewModel.isLoggedIn {
                // Delegate to MainTabView which provides a TabView with per-tab NavigationStacks
                MainTabView()
            } else {
                LoginView(viewModel: loginViewModel)
                    .onReceive(loginViewModel.uiEvents) { event in
                        switch event {
                        case .navigateHome:
                            loginViewModel.isLoggedIn = true
                        case .navigateCompleteProfile:
                            loginViewModel.isProfileComplete = true
                        case .showError:
                            // Errors are handled locally in the LoginView (alert), so ignore here
                            break
                        }
                    }
            }
        }
    }
}

// MARK: - Lightweight stubs
// If your project already has `LoginView`, it will be used. Kept here as a private lightweight implementation.
private struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    // Local presentation state (alerts)
    @State private var alertMessage: String?
    @State private var showingAlert: Bool = false

    // Focus handling
    enum Field: Hashable {
        case email, password
    }
    @FocusState private var focusedField: Field?

    var body: some View {
        // Bindings into the view model's uiState
        let emailBinding = Binding<String>(
            get: { viewModel.uiState.email },
            set: { viewModel.onEmailChanged($0) }
        )
        let passwordBinding = Binding<String>(
            get: { viewModel.uiState.password },
            set: { viewModel.onPasswordChanged($0) }
        )

        VStack(alignment: .center, spacing: 0) {
            LoginScreenHeader()

            VStack(spacing: 12) {
                LoginScreenFields(
                    email: emailBinding,
                    password: passwordBinding,
                    isLoading: viewModel.uiState.isLoading,
                    focusedField: $focusedField,
                    onSubmit: viewModel.onContinueWithEmailSubmit
                )

                if viewModel.uiState.isEmailVerificationSent {
                    LoginScreenEmailSent(
                        onCheckEmailVerified: viewModel.onCheckEmailVerified,
                        onResendVerificationEmail: viewModel.onResendVerificationEmail
                    )
                } else {
                    LoginScreenButtons(
                        isLoading: viewModel.uiState.isLoading,
                        onContinueWithEmailSubmit: viewModel.onContinueWithEmailSubmit,
                        onGoogleSignIn: viewModel.onGoogleIntentRequested
                    )
                }
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .padding(.top, 24)
        .onReceive(viewModel.uiEvents) { event in
            switch event {
            case .showError(let message):
                alertMessage = message
                showingAlert = true
            default:
                break
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(""), message: Text(alertMessage ?? ""), dismissButton: .default(Text("OK"), action: { alertMessage = nil }))
        }
    }
}

// MARK: - Subcomponents

private struct LoginScreenHeader: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Welcome to PedalPal")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            LogoImage()
                .frame(width: 120, height: 120)
                .padding(.top, 8)
        }
        .padding(.bottom, 8)
    }
}

private struct LogoImage: View {
    var body: some View {
        // Replace with your app asset if available
        Image("mobi_bike_logo")
            .resizable()
            .scaledToFit()
            .foregroundColor(.accentColor)
    }
}

private struct LoginScreenFields: View {
    @Binding var email: String
    @Binding var password: String
    var isLoading: Bool
    var focusedField: FocusState<LoginView.Field?>.Binding
    var onSubmit: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textContentType(.username)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.25)))
                .focused(focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField.wrappedValue = .password
                }

            SecureField("Password", text: $password)
                .textContentType(.password)
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.25)))
                .focused(focusedField, equals: .password)
                .submitLabel(.go)
                .onSubmit {
                    focusedField.wrappedValue = nil
                    onSubmit()
                }

            Spacer().frame(height: 16)
        }
    }
}

private struct LoginScreenButtons: View {
    var isLoading: Bool
    var onContinueWithEmailSubmit: () -> Void
    var onGoogleSignIn: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Button(action: onContinueWithEmailSubmit) {
                Text("Sign In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isLoading ? Color.gray : Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(isLoading)

            Button(action: onGoogleSignIn) {
                Text("Continue with Google")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.secondary.opacity(0.25)))
            }
            .disabled(isLoading)
        }
    }
}

private struct LoginScreenEmailSent: View {
    var onCheckEmailVerified: () -> Void
    var onResendVerificationEmail: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text("Check your email, verify your account,\nthen come back and tap below.")
                .multilineTextAlignment(.center)
                .font(.body)

            Button(action: onCheckEmailVerified) {
                Text("I've verified my email")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            HStack {
                Text("Didn't receive the email, resend it by clicking")
                    .font(.footnote)
                Button(action: onResendVerificationEmail) {
                    Text("here")
                        .underline()
                        .font(.footnote)
                        .foregroundColor(.accentColor)
                }
            }
            .padding(.top, 4)
        }
    }
}

private struct ResendInlineText: View {
    var onResend: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            Text("Didn't receive the email, resend it by clicking ")
            Button(action: onResend) {
                Text("here")
                    .underline()
                    .foregroundColor(.accentColor)
            }
            .buttonStyle(.plain)
            Text(".")
        }
        .font(.footnote)
    }
}

// MARK: - Previews
struct AuthGateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthGateView()
    }
}
