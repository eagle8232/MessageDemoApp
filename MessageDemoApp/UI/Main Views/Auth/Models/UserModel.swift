//
//  UserModel.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

struct UserModel: Identifiable {
    var id = UUID()
    var email: String
    var password: String
}
