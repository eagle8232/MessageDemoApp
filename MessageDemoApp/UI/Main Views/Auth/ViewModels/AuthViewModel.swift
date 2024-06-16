//
//  LoginViewModel.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userModel: UserModel = UserModel(email: "", password: "")
    @Published var currentUser: User? = nil
    
    let firebaseManager: FirebaseManager = .shared
    
    init() {
        self.currentUser = self.checkUser()
    }
    
    func checkUser() -> User? {
        if let user = firebaseManager.checkUser() {
            self.currentUser = user
            return user
        } else {
            return nil
        }
    }
    
    func createUser(with email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        firebaseManager.createUser(with: email, password: password) { user, error in
            guard let user, error == nil else {
                completion(error)
                return
            }
            self.currentUser = user
            completion(nil)
        }
    }
    
    func signIn(with email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        firebaseManager.signIn(with: email, password: password) { user, error in
            guard let user, error == nil else {
                completion(error)
                return
            }
            self.currentUser = user
            completion(nil)
        }
    }
    func signOut() {
        do {
            try firebaseManager.signOut()
            currentUser = nil
        } catch {
            print(error)
        }
    }
}
