//
//  RegisterView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 16.06.24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    // - Register View's Values
    @State var emailText: String = ""
    @State var passwordText: String = ""
    @State var confirmPasswordText: String = ""
    
    @State var error: Error? = nil
    
    var body: some View {
        ZStack {
            VStack {
                textFieldsView
                createButtonView
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
            CustomTextField(text: $confirmPasswordText, placeholder: "Confirm Password", isSecure: true)
        }
    }
    
    var createButtonView: some View {
        CustomButton(style: .rounded("Sign Up", nil)) {
            authVM.createUser(with: emailText, password: passwordText) { error in
                guard let error else { return }
                self.error = error
            }
        }
    }
}
 #Preview {
    RegisterView()
}
