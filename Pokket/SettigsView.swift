//
//  SettigsView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import SwiftUI

struct SettigsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        // We have a logged in user, go to ChatView
        NavigationStack {
            Text("Welcome to FireChat!")
                .navigationTitle("Chat")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem {
                        Button("Sign out") {
                            authViewModel.signOut()
                        }
                    }
                }
        }
    }
}

#Preview {
    SettigsView()
}
