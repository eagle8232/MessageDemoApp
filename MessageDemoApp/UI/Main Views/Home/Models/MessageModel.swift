//
//  MessageModel.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

enum UserRole: Codable {
    case sender
    case receiver
}

struct MessageModel: Codable, Identifiable {
    var id = UUID()
    let user: UserRole
    var text: String
    let date: Date
}
