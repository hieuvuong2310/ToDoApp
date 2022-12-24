//
//  SignUpView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//

import SwiftUI
import Introspect
struct SignUpView: View {
    @ObservedObject private var viewModel: SignUpViewModel = SignUpViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Create Account")
                    .bold()
                    .font(.largeTitle)
                Text("Sign up with email.")
                    .foregroundColor(Color(.secondaryText))
                Rectangle()
                    .foregroundColor(.white)
                    .frame(maxHeight: 62)
                VStack(alignment: .leading) {
                    TextField("Name", text: $viewModel.name)
                        .padding(.horizontal, 16.0)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 60)
                        .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                        })
                    Divider()
                    TextField("Email", text: $viewModel.email)
                        .padding(.horizontal, 16.0)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 60)
                        .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                        })
                    Divider()
                    SecureField("Password", text: $viewModel.password)
                        .padding(.horizontal, 16.0)
                        .textInputAutocapitalization(.never)
                        .frame(minHeight: 60)
                        .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                        })
                    Divider()
                    HStack {
                        Button(action: {
                            viewModel.checkBoxTapped()
                        }, label: {
                            Image(systemName: (viewModel.isCheckBoxTapped ?  "checkmark.square.fill" : "squareshape"))
                                .frame(minWidth: Constants.checkBoxSize, minHeight: Constants.checkBoxSize)
                        }
                        )
                        Text("I agree with our")
                            .font(.caption)
                            .foregroundColor(Color(.secondaryText))
                        Text("Terms")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color(.checkmarkButton))
                        Text("and")
                            .font(.caption)
                            .foregroundColor(Color(.secondaryText))
                        Text("Conditions")
                            .font(.caption)
                            .bold()
                            .foregroundColor(Color(.checkmarkButton))
                    }
                    .padding(.leading, 16)
                }
                Spacer()
                RoundedRectangle(cornerRadius: 14)
                    .frame(maxWidth: 343, maxHeight: 56)
                    .foregroundColor(Color(.checkmarkButton))
                    .overlay(content: {
                        Text("Create Account")
                            .foregroundColor(.white)
                    })
                    .onTapGesture {
                        viewModel.signUp()
                    }
            }
            HStack {
                Text("Already have an account?")
                    .foregroundColor(Color(.secondaryText))
                Text("Sign In")
                    .foregroundColor(Color(.checkmarkButton))
                    .onTapGesture {
                        viewModel.navigateToSignIn()
                    }
            }
        }
        .alert(item: $viewModel.error, content: { error in
            switch error {
            case .invalidEmail:
                return Alert(title: Text("Error"), message: Text("Invalid email."))
            case .invalidPassword:
                return Alert(title: Text("Error"), message: Text("Invalid password."))
            case .invalidName:
                return Alert(title: Text("Error"), message: Text("Invalid name."))
            case .authenticationError:
                return Alert(title: Text("Error"), message: Text("Cannot create account."))
            }
        })
    }
}

private extension SignUpView {
    enum Constants {
        static let checkBoxSize: CGFloat = 16
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
