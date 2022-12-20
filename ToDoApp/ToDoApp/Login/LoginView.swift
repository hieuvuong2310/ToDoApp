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
                Text("Login")
                    .bold()
                    .font(.largeTitle)
                Text("Welcome Back")
                    .foregroundColor(Color(.secondaryText))
                TextField("Email", text: $viewModel.email)
                    .padding(.horizontal, 16.0)
                    .frame(minHeight: 44)
                    .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                    })
                Divider()
                TextField("Password", text: $viewModel.password)
                    .padding(.horizontal, 16.0)
                    .frame(minHeight: 44)
                    .introspectTextField(customize: {
                            $0.clearButtonMode = .whileEditing
                    })
                Divider()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
