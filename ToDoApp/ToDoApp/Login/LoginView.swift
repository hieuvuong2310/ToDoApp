//
//  LoginView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//
import SwiftUI
import Introspect

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Login")
                    .bold()
                    .font(.largeTitle)
                Text("Welcome Back.")
                    .foregroundColor(Color(.secondaryText))
                Rectangle()
                    .foregroundColor(.white)
                    .frame(maxHeight: 62)
                TextField("Email", text: $viewModel.email)
                    .padding(.horizontal, 16.0)
                    .textInputAutocapitalization(.never)
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
                RoundedRectangle(cornerRadius: 14)
                    .frame(maxWidth: 343, maxHeight: 56)
                    .foregroundColor(Color(.primaryButton))
                    .overlay(content: {
                        Text("Sign In")
                            .foregroundColor(.white)
                    })
                    .onTapGesture {
                        viewModel.signIn()
                    }
            }
            HStack {
                Text("Don't have account?")
                    .foregroundColor(Color(.secondaryText))
                Text("Create account")
                    .foregroundColor(Color(.checkmarkButton))
                    .onTapGesture {
                        viewModel.navigateToSignUp()
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
        LoginView()
    }
}
