//
//  LoginView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//
import SwiftUI
import Introspect

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
            VStack {
                Spacer()
                Text("Login")
                    .bold()
                    .font(.largeTitle)
                Text("Welcome Back.")
                    .foregroundColor(Color(.secondaryText))
                Spacer()
                    .frame(maxHeight: 62)
                TextField("Email", text: $viewModel.email)
                    .padding(.horizontal, 16.0)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .frame(minHeight: 44)
                    .introspectTextField(customize: {
                        $0.clearButtonMode = .whileEditing
                    })
                Divider()
                HStack {
                    SecureField("Password", text: $viewModel.password)
                        .padding(.horizontal, 16.0)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 44)
                        .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                        })
                    Text("Forgot password?")
                        .foregroundColor(Color(.checkmarkButton))
                        .padding(.trailing, 16)
                        .onTapGesture {
                            viewModel.forgotPassword()
                        }
                }
                Divider()
                Spacer()
                Button("Sign In") {
                    viewModel.signInButtonTapped()
                }
                .foregroundColor(.white)
                .buttonStyle(.bordered)
                .frame(maxWidth: 343, maxHeight: 56)
                .background(Color(.checkmarkButton))
            }
            Button(action: {
                viewModel.signUpButtonTapped()
            }) {
                Text("Don't have account? Create account")
                { string in
                    string.foregroundColor = Color(.secondaryText)
                    if let range = string.range(of: "Create account") {
                        string[range].foregroundColor = Color(.checkmarkButton)
                    }
                }
            }
        .alert(item: $viewModel.error, content: { error in
            switch error {
            case .invalidEmail:
                return Alert(title: Text("Error"), message: Text("Invalid email."))
            case .invalidPassword:
                return Alert(title: Text("Error"), message: Text("Invalid password."))
            case .authenticationError:
                return Alert(title: Text("Error"), message: Text("Login failed."))
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(onSignUp: {}, onLogin: { _ in }))
    }
}
