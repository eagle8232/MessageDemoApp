//
//  View + Extension.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 16.06.24.
//

import SwiftUI

extension View {
    
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    // MARK: - Animation
    func customAnimation(type: CustomAnimationType) -> some View {
        self.modifier(CustomAnimation(animationType: type))
    }
    
    // MARK: - Notificaiton & Alert Views
    // Error Views
    
    /// - Showing error as a notification
    func showErrorNotificationView(error: Error, completion: @escaping () -> Void) -> some View {
        NotificationView(type: .error(error), completion: completion)
    }
    
    /// - Showing error as an alert view
    func showErrorAlertView(error: Error, completion: @escaping () -> Void) -> some View {
        CustomAlertView(type: .error(error)) {
            completion()
        }
    }
    
    // Success Views
    
    /// - Showing success message as a notification
    func showSuccessNotificationView(message: String, completion: @escaping () -> Void) -> some View {
        NotificationView(type: .success(message), completion: completion)
    }
    
    /// - Showing error as an alert view
    func showSuccessAlertView(completion: @escaping () -> Void) -> some View {
        CustomAlertView(type: .success) {
            completion()
        }
    }
}
