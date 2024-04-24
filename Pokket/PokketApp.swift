//
//  PokketApp.swift
//  Pokket
//
//  Created by Minh Huynh on 4/19/24.
//

import SwiftUI
import FirebaseCore

@main
struct PokketApp: App {

    @State private var authViewModel: AuthViewModel

    init() {
        FirebaseApp.configure()
        authViewModel = AuthViewModel()
    }

    var body: some Scene {
        WindowGroup {
            if authViewModel.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)

                // We have a logged in user, go to MainView
                NavigationStack {
                    MainView()
                        .environment(authViewModel)
                }
            } else {

                // No logged in user, go to LoginView
                LoginView()
                    .environment(authViewModel)
            }
        }
    }
}

