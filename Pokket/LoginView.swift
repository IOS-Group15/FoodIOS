//
//  LoginView.swift
//  Pokket
//
//  Created by Fredy Camas on 4/23/24.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var saveUsername: Bool = false
    @State private var showPassword: Bool = false
    @State private var isEmailValid: Bool = true
    @State private var showInvalidEmailMessage: Bool = false
   
    @Environment(AuthViewModel.self) var authViewModel
    
    @State var isNavigationg = true
    
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
                        .onChange(of: email, perform: { value in
                            isEmailValid = value.isValidEmail()
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
                        authViewModel.signIn(email: email, password: password)
                        
                        }
                    }) {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: SignUpView()) {
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
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $isNavigationg) {
                MainView()
            }
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


#Preview {
    LoginView()
}
