//
//  AuthViewModel.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthViewModel: ObservableObject {
    // A property to store the logged in user. User is an object provided by FirebaseAuth framework
    @Published var user: User?
    @Published var signInState: SignInState = .signedOut
    var authError: PassthroughSubject<String, Never> = PassthroughSubject()

    // Determines if AuthManager should use mocked data
    let isMocked: Bool

    var userEmail: String? {
        // If mocked, return a mocked email string, otherwise return the users email if available
        isMocked ? "pakket@gmail.com" : user?.email
    }

    init(isMocked: Bool = false) {
        self.isMocked = isMocked
        // Listen for authentication state changes
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.user = user
            self?.signInState = user == nil ? .signedOut : .signedIn
        }
    }
    
    enum SignInState {
        case signedIn
        case signedOut
        case error(String)
    }

    func signUp(name: String, email: String, password: String) async throws {
        do {
            let userReference = Firestore.firestore().collection("Users")
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await userReference.document(result.user.uid).setData(["name": name, "email": email])
        } catch {
            authError.send("Failed to sign up: \(error.localizedDescription)")
            throw error
        }
    }


    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user // <-- Set the user
            signInState = .signedIn
        } catch {
            authError.send("Failed to sign in: \(error.localizedDescription)")
            signInState = .error(error.localizedDescription)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil // <-- Set user to nil after sign out
            signInState = .signedOut
        } catch {
            authError.send("Error signing out: \(error.localizedDescription)")
            signInState = .error(error.localizedDescription)
        }
    }
}


