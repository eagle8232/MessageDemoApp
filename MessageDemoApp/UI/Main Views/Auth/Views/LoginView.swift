//
//  LoginView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State var emailText: String = ""
    @State var passwordText: String = ""
    
    @State var error: Error? = nil
    
    var body: some View {
        ZStack {
            VStack {
                textFieldsView
                loginButtonView
                Spacer()
                registerButtonView
            }
            .padding()
            
            if let error {
                showErrorNotificationView(error: error) {
                    self.error = nil
                }
            }
        }
    }
    
    var textFieldsView: some View {
        VStack {
            CustomTextField(text: $emailText, placeholder: "Email", isSecure: false)
            CustomTextField(text: $passwordText, placeholder: "Password", isSecure: true)
        }
    }
    
    var loginButtonView: some View {
        CustomButton(style: .text("Log In")) {
            authVM.signIn(with: emailText, password: passwordText) {error in
                guard let error else { return }
                self.error = error
            }
        }
    }
    
    var registerButtonView: some View {
        NavigationLink {
            RegisterView()
        } label: {
            Text("New User? Register Now!")
        }
    }
    
    
}

#Preview {
    LoginView()
}
