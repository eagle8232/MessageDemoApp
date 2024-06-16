//
//  MessagesView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

struct MessagesView: View {
    let messages: [MessageModel]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(messages, id: \.date ) { message in
                    MessageCellView(message: message)
                        .padding(10)
                }
            }
        }
    }
}
