//
//  SettigsView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(authViewModel.name ?? "")!")
                List {
                    NavigationLink(destination: NotificationSettingsView()) {
                        Label("Notification Settings", systemImage: "folder.fill.badge.gearshape")
                    }
                }
            }.navigationBarTitle("Pokket") // Set navigation title here
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Spacer()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Sign out") {
                            authViewModel.signOut()
                        }
                    }
                }
                .font(.headline)
            
        }.onAppear {
            Task {
                do {
                    try await authViewModel.fetchUserName()
                } catch {
                    print("Error fetching user name: \(error.localizedDescription)")
                }
            }
        }
    }
}



#Preview {
    SettingsView()
}
