//
//  HomeView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @ObservedObject var messageVM: MessageViewModel = MessageViewModel()
    
    @State var currentText: String = ""
    
    var body: some View {
        ZStack {
            AuroraView()
                .ignoresSafeArea()
                
            content
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    authVM.signOut()
                } label: {
                    Text("Sign out")
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    var content: some View {
        VStack {
            MessagesView(messages: messageVM.messages)
            bottomBarView
        }
    }
    
    var bottomBarView: some View {
        HStack(alignment: .center) {
            CustomTextField(text: $currentText, isSecure: false)
            sendButtonView
        }
        .padding()
    }
    
    var sendButtonView: some View {
        CustomButton(style: .circled(nil, Image(uiImage: .send)), blurStyle: .light) {
            sendMessage()
        }
    }
    
    func sendMessage() {
        messageVM.sendMessage(text: currentText)
        currentText = "" /// - After sending message, we need to empty it
    }
}
