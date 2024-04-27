//
//  LoginView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var saveUsername: Bool = false
    @State private var showPassword: Bool = false
    @State private var isEmailValid: Bool = true
    @State private var showInvalidEmailMessage: Bool = false
    @State private var isSigningIn: Bool = false
    @State private var signInError: String?
    
    // Store subscriptions
    private var cancellables = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            VStack {
                Image("ic-logo")
                    .resizable()
                    .frame(width: 100, height: 100)

                VStack(alignment: .leading, spacing: 16) {
                    TextField("Email", text: $email)
                        .font(.system(size: 20))
                        .autocapitalization(.none)
                        .onChange(of: email) { value in
                            isEmailValid = value.isValidEmail()
                        }
                        .foregroundColor(isEmailValid ? .black : .red)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)

                    if !isEmailValid && showInvalidEmailMessage {
                        Text("Please enter a valid email")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }

                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                        } else {
                            SecureField("Password", text: $password)
                        }

                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    .font(.system(size: 20))

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)

                    HStack {
                        Image(systemName: saveUsername ? "checkmark.square" : "square")
                            .foregroundColor(saveUsername ? .green : .gray)
                            .onTapGesture {
                                saveUsername.toggle()
                            }
                            .font(.system(size: 20))
                        
                        Text("Save username")
                            .font(.system(size: 16))
                    }
                }
                .padding(.horizontal, 32)

                HStack {
                    Button(action: {
                        showInvalidEmailMessage = !isEmailValid
                        if isEmailValid {
                            signIn()
                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }

                    NavigationLink(destination: SignUpView().environmentObject(authViewModel)) {
                        Text("Sign Up")
                            .foregroundColor(.green)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 32)

                HStack {
                    Spacer()

                    Text("Forgot email and password?")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))

                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
            }
            .alert("Error", isPresented: $authViewModel.isSigningIn) {
                Button("OK", role: .cancel) {
                    authViewModel.isSigningIn = false
                }
            } message: {
                Text(authViewModel.signInError ?? "An unknown error occurred")
            }
        }
    }
    


    private func signIn() {
        Task {
            await authViewModel.signIn(email: email, password: password)
                }
            }
        }



extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
