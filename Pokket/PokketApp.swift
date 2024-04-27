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
    @StateObject private var authViewModel = AuthViewModel()  // Use StateObject for lifecycle management

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.user != nil { // <-- Check if you have a non-nil user (means there is a logged in user)
                NavigationStack {
                    MainView()
                        .environmentObject(authViewModel)  // Pass AuthViewModel using environmentObject
                        .navigationTitle("Pokket")
                        .navigationBarTitleDisplayMode(.inline)
                }
            } else {
                // No logged in user, go to LoginView
                LoginView()
                    .environmentObject(authViewModel)
            }
        }
    }
}

