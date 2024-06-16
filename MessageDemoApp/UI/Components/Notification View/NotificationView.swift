//
//  NotificationView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 16.06.24.
//

import SwiftUI

struct NotificationView: View {
    let type: NotificationType
    
    @State private var timer: Timer? = nil
    @State private var opacity: Double = 0 // Start invisible
    @State private var yOffset: Double = -50 // Start off-screen
    
    let completion: () -> Void
    
    var body: some View {
        contentView
            .onAppear {
                animateNotificationView()
            }
    }

    var contentView: some View {
        ZStack {
            switch type {
            case .success(let message):
                successView(message: message)
            case .error(let error):
                errorView(error: error)
            }
        }
        .opacity(opacity)
        .offset(y: yOffset)
    }

    func successView(message: String) -> some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Success")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(message)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: Constant.cornerRadius)
                .fill(Color.green)
        }
        .padding(.horizontal)
    }

    func errorView(error: Error) -> some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Error")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(error.localizedDescription)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: Constant.cornerRadius)
                .fill(Color.red)
        }
        .padding(.horizontal)
    }

    func animateNotificationView() {
        withAnimation(.easeOut(duration: 0.5)) {
            opacity = 1
            yOffset = 0
        }

        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            withAnimation(.easeIn(duration: 0.5)) {
                opacity = 0
                yOffset = -50
                completion()
            }
        }
    }
}
