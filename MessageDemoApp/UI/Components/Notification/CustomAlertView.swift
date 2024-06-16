//
//  NotificationView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 16.06.24.
//

import SwiftUI

struct CustomAlertView: View {
    // - UI Values
    var title: String?
    var message: String?
    let type: AlertType // - Alert Type (e.g. error, warning or success types)
    
    let cancelHandler: () -> Void
    var actionHandler: (() -> Void)?
    
    var body: some View {
        ZStack {
            switch type {
            case .success:
                contentView(title: title ?? "", message: message ?? "")
            case .error(let error):
                contentView(title: "Error", message: error.localizedDescription)
            case .warning:
                contentView(title: title ?? "", message: message ?? "")
            }
        }
        .background {
            backgroundView
        }
    }
    
    func contentView(title: String, message: String) -> some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(message)
                .font(.callout)
            
            buttonsView
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    var backgroundView: some View {
        CustomBlurView(style: .extraLight)
            .ignoresSafeArea()
            .clipShape(RoundedRectangle(cornerRadius: Constant.cornerRadius))
    }
    
    var buttonsView: some View {
        HStack {
            switch type {
            case .success:
                // - OK Button
                CustomButton(style: .rounded("OK", nil), blurStyle: .light) {
                    cancelHandler()
                }
            case .error(_):
                // - OK Button
                CustomButton(style: .rounded("OK", nil), blurStyle: .light) {
                    cancelHandler()
                }
            case .warning:
                // - Cancel Button
                CustomButton(style: .rounded("Cancel", nil), blurStyle: .light) {
                    cancelHandler()
                }
                Spacer()
                // - Action Button
                CustomButton(style: .rounded("Submit", nil)) {
                    actionHandler?()
                }
            }
        }
        .padding()
    }
}

