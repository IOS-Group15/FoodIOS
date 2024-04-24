//
//  SigUpView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import SwiftUI

struct SignUpView: View {
    @Environment(AuthViewModel.self) var authViewModel
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var agreeToTerms: Bool = false
    @State private var isEmailValid: Bool = true
    @State private var showInvalidEmailMessage: Bool = false
    @State private var isPasswordValid: Bool = true
    @State private var showPassword: Bool = false
    @State private var passwordsMatch: Bool = true
    @State private var isSignUpSuccessful: Bool = false
    @State private var signUpButtonPressed: Bool = false // Track if sign-up button is pressed
    
    var body: some View {
        NavigationView {
            VStack {
                Image("ic-logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading, spacing: 16) {
                    TextField("Name", text: $name)
                        .font(.system(size: 20))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    TextField("Email", text: $email)
                        .font(.system(size: 20))
                        .autocapitalization(.none)
                        .onChange(of: email, perform: { value in
                            isEmailValid = value.isValidEmail()
                            showInvalidEmailMessage = false // Reset error message when email changes
                        })
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
                                .font(.system(size: 20))
                        } else {
                            SecureField("Password", text: $password)
                                .font(.system(size: 20))
                        }
                        
                        // Show/hide password toggle
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .font(.system(size: 20))
                        .onChange(of: confirmPassword, perform: { value in
                            passwordsMatch = value == password
                        })
                        .foregroundColor(passwordsMatch ? .black : .red)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    if !passwordsMatch {
                        Text("Passwords do not match")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                    
                    HStack {
                        Image(systemName: agreeToTerms ? "checkmark.square" : "square")
                            .foregroundColor(agreeToTerms ? .green : .gray)
                            .onTapGesture {
                                agreeToTerms.toggle()
                            }
                            .font(.system(size: 20))
                        
                        Text("I agree to Terms & Conditions")
                            .font(.system(size: 16))
                    }
                    
                    if signUpButtonPressed && !agreeToTerms {
                        Text("Please agree to Terms & Conditions")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal, 32)
                
                Button(action: {
                    signUpButtonPressed = true // Set the flag when sign-up button is pressed
                    signUp()
                }) {
                    
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 32)
                .fullScreenCover(isPresented: $isSignUpSuccessful, content: MainView.init)
                
            }
        }
    }
    
    func signUp() {
        guard agreeToTerms else {
            // Show alert or handle agreement not checked
            // For example, you can set a flag to show an error message
            // or display an alert to inform the user that they need to agree to terms
            // Here, I'll just print a message
            print("Please agree to the Terms & Conditions")
            return
        }
        
        guard password == confirmPassword else {
            // Show alert or handle password mismatch
            passwordsMatch = false
            return
        }
        
        isPasswordValid = password.count >= 6 // Password validation
        
        if !isEmailValid || !passwordsMatch || !isPasswordValid {
            // Validation failed
            return
        }
        
        Task {
            do {
                try await authViewModel.signUp(name: name, email: email, password: password)
                print("signed up")
                isSignUpSuccessful = true
                // Handle successful signup
            } catch {
                // Handle signup error
                print("Error at SignUP \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    SignUpView()
}

