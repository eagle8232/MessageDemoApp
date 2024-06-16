//
//  HomeViewModel.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

class MessageViewModel: ObservableObject {
    @Published var messages: [MessageModel] = []
    @Published var currentMessage: MessageModel?
    init() {
        Task {
            await fetchMessages()
        }
    }
    
    // MARK: - Firebase
    
    private let firebaseManager: FirebaseManager = .shared
    
    @MainActor
    public func fetchMessages() {
        firebaseManager.fetchDataFromFirestore(value: messages, for: .messages) { [weak self] messages, error in
            guard let self, let messages, error == nil else { return }
            withAnimation {
                self.messages = messages
            }
        }
    }
    
    public func sendMessage(text: String) {
        currentMessage = MessageModel(user: .sender, text: text, date: Date())
        if let newMessage = currentMessage,
           newMessage.text != "" {
            messages.append(newMessage)
            saveMessagesToFirestore()
            currentMessage?.text = ""
            currentMessage = nil
        }
    }
    
    /// - Private functions
    private func saveMessagesToFirestore() {
        firebaseManager.saveDataToFirestore(value: messages, for: .messages) { [weak self] error in
            guard let self else {return}
            
            if let error {
                
            } else {
                Task {
                    await self.fetchMessages()
                }
            }
        }
    }
}
