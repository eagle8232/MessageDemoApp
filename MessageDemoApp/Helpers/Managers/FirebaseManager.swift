//
//  FirebaseManager.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    private init() {}
    
    public func checkUser() -> User? {
        if let user = auth.currentUser {
            return user
        }
        return nil
    }
    
    // Data Manupilation
    
    /// - Saves messages to Firestore
    public func saveDataToFirestore<T: Codable>(value: T, for key: DataCollectionNameKeys, completion: @escaping (Errors?) -> Void) {
        if let user = checkUser() {
            let docRef = db.collection(user.email ?? user.uid).document(key.toString)
            guard let encodedData = try? JSONEncoder().encode(value) else { return }
            let data: [String: Any] = [
                key.toString: encodedData
            ]
            docRef.setData(data)
        } else {
            completion(.noUser)
        }
    }
    
    /// - Fetches messages from Firestore
    public func fetchDataFromFirestore<T: Codable>(value: T, for key: DataCollectionNameKeys, completion: @escaping (T?, Error?) -> Void) {
        if let user = checkUser() {
            let docRef = db.collection(user.email ?? user.uid).document(key.toString)
            docRef.getDocument { document, error in
                guard let document, error == nil else {
                    completion(nil, error)
                    return
                }
                guard let decodedData = document.data()?[key.toString] as? Data,
                      let messages = try? JSONDecoder().decode(T.self, from: decodedData) else { return }
                completion(messages, nil)
            }
        }
    }
    
    // Auth
    
    /// - Creates a new user
    public func createUser(with email: String, password: String, completion: @escaping ((User?, Error?) -> Void)) {
        auth.createUser(withEmail: email, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                completion(nil, error)
                return
            }
            completion(user, nil)
        }
    }
    
    /// - Log in to existing user
    public func signIn(with email: String, password: String, completion: @escaping ((User?, Error?) -> Void)) {
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let user = result?.user, error == nil else {
                completion(nil, error)
                return
            }
            completion(user, nil)
        }
    }
    
    public func signOut() throws {
        try auth.signOut()
        
    }
    
}
