//
//  SigUpView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
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
    @State private var errorMessage: String = ""
    
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
//                    .font(.system(size: 20))
                    
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
                .alert(isPresented: $isSignUpSuccessful) {
                    Alert(title: Text("Sign Up Successful"), message: Text("You are now signed up and logged in."), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: Binding<Bool>.constant(!errorMessage.isEmpty), content: {
                    Alert(title: Text("Sign Up Error"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                        // Clear the error message after showing the alert
                        errorMessage = ""
                    }))
                })
            }
        }
    }
    
    func signUp() {
        guard agreeToTerms else {
            // Show alert or handle agreement not checked
            // For example, you can set a flag to show an error message
            // or display an alert to inform the user that they need to agree to terms
            // Here, I'll just print a message
            errorMessage = "Please agree to the Terms & Conditions"
            return
        }
        
        guard password == confirmPassword, password.count >= 6 else {
            errorMessage = "Password validation failed: Ensure passwords match and are at least 6 characters."
            return
        }
        
        guard isEmailValid else {
            errorMessage = "Please enter a valid email"
            return
        }
        
        Task {
            do {
                try await authViewModel.signUp(name: name, email: email, password: password)
                isSignUpSuccessful = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    SignUpView()
}

