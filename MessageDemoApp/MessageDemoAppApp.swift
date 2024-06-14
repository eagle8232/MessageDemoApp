//
//  MessageDemoAppApp.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

@main
struct MessageDemoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
