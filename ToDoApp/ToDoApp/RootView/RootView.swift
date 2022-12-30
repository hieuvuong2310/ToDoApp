//
//  RootView.swift
//  ToDoApp
//
//  Created by Trong Hieu Vuong on 2022-12-29.
//

import SwiftUI

struct RootView: View {
    @ObservedObject private var viewModel: RootViewModel = RootViewModel()
    var body: some View {
        switch viewModel.destination {
        case .list(let viewModel):
            ToDoListView(viewModel: viewModel)
        case .login(let viewModel):
            LoginView(viewModel: viewModel)
        case .signup(let viewModel):
            SignUpView(viewModel: viewModel)
        case .none:
            Text("Error launching the app")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
