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
            ZStack {
                VStack {
                    Text("Welcome, \(authViewModel.name ?? "")!")
                    List {
                        NavigationLink(destination: NotificationSettingsView()) {
                            Label("Notification Settings", systemImage: "folder")
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    Button("LOGOUT") {
                        authViewModel.signOut()
                    }
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(10)
                }.padding()
            }.tint(.gray)
        }
        .onAppear {
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
