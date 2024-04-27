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
    @Published var user: User?
    @Published var signInState: SignInState = .signedOut
    @Published var signInError: String = ""  
    @Published var isSigningIn: Bool = false
    @Published var name:String?

    private var cancellables = Set<AnyCancellable>()
    let isMocked: Bool

    init(isMocked: Bool = false) {
        self.isMocked = isMocked
        Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            self?.user = user
            self?.signInState = user == nil ? .signedOut : .signedIn
        }
    }

    enum SignInState {
        case signedIn, signedOut, error(String)
    }

    func signUp(name: String, email: String, password: String) async throws {
        do {
            let userReference = Firestore.firestore().collection("Users")
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            try await userReference.document(result.user.uid).setData(["name": name, "email": email])
        } catch {
            signInError = "Failed to sign up: \(error.localizedDescription)"
            throw error
        }
    }

    func signIn(email: String, password: String) async {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            user = authResult.user // <-- Set the user
            signInState = .signedIn
        } catch {
            signInError = "Failed to sign in: \(error.localizedDescription)"
            signInState = .error(signInError)
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil // <-- Set user to nil after sign out
            signInState = .signedOut
        } catch {
            signInError = "Error signing out: \(error.localizedDescription)"
            signInState = .error(signInError)
        }
    }
    
    func fetchUserName() async throws {
        guard let userId = user?.uid else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User is not authenticated"])
        }

        let userReference = Firestore.firestore().collection("Users").document(userId)
        do {
            let documentSnapshot = try await userReference.getDocument()
            guard let userData = documentSnapshot.data(),
                  let userName = userData["name"] as? String else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User name not found"])
            }

            DispatchQueue.main.async {
                self.name = userName
            }
        } catch {
            DispatchQueue.main.async {
                self.signInError = "Failed to fetch user name: \(error.localizedDescription)"
                self.signInState = .error(self.signInError)
            }
        }
    }

}

