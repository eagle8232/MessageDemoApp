//
//  ContentView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    
    var body: some View {
        NavigationView {
            if let _ = authVM.currentUser {
                HomeView()
            } else {
                LoginView()
            }
        }
        .environmentObject(authVM)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

