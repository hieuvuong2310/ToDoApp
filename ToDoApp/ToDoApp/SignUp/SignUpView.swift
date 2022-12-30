//
//  SignUpView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-20.
//
import SwiftUI
import Introspect
struct SignUpView: View {
    @ObservedObject private var viewModel: SignUpViewModel
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Create Account")
                    .bold()
                    .font(.largeTitle)
                Text("Sign up with email.")
                    .foregroundColor(Color(.secondaryText))
                Spacer()
                    .frame(maxHeight: 62)
                VStack(alignment: .leading) {
                    TextField("Name", text: $viewModel.name)
                        .padding(.horizontal, 16.0)
                        .textContentType(.name)
                        .frame(minHeight: 60)
                        .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                        })
                    Divider()
                    TextField("Email", text: $viewModel.email)
                        .padding(.horizontal, 16.0)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
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
                            viewModel.acceptTermsAndConditionsCheckBoxTapped()
                        }, label: {
                            Image(systemName: (viewModel.isAcceptTermsAndConditionsChecked ?  "checkmark.square.fill" : "squareshape"))
                                .frame(minWidth: Constants.checkBoxSize, minHeight: Constants.checkBoxSize)
                        }
                        )
                        Text("I agree with our Terms and Conditions")
                        { string in
                            string.foregroundColor = Color(.secondaryText)
                            string.font = .caption
                            if let range = string.range(of: "Terms") {
                                string[range].foregroundColor = Color(.checkmarkButton)
                            }
                            if let range = string.range(of: "Conditions") {
                                string[range].foregroundColor = Color(.checkmarkButton)
                            }
                        }
                    }
                    .padding(16)
                }
                Spacer()
                Button("Create Account") {
                    viewModel.signUpButtonTapped()
                }
                .foregroundColor(.white)
                .buttonStyle(.bordered)
                .frame(maxWidth: 343, maxHeight: 56)
                .background(Color(.checkmarkButton))
            }
            Button(action: {
                viewModel.signInButtonTapped()
            }) {
                Text("Already have an account? Sign In")
                         { string in
                             string.foregroundColor = Color(.secondaryText)
                             if let range = string.range(of: "Sign In") {
                                 string[range].foregroundColor = Color(.checkmarkButton)
                             }
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
extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string)
        configure(&attributedString)
        self.init(attributedString)
    }
}
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(onSignUp: {_ in "JtZM8oqs8pTsTBVfgmVhio8PbjG3"}, onLogin: {}))
    }
}
