//
//  MessageCellView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

struct MessageCellView: View {
    let message: MessageModel
    
    var body: some View {
        HStack {
            if message.user == .sender {
                Spacer()
            }
            
            VStack {
                Text(message.text)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(message.user == UserRole.sender ? .leading : .trailing)
            }
            .padding()
            .background {
                CustomBlurView(style: .systemUltraThinMaterialLight)
                    .foregroundStyle(message.user == UserRole.sender ? .blue : .white)
                    .clipShape(Capsule())
            }
            
            if message.user == .receiver {
                Spacer()
            }
        }
    }
    
}

