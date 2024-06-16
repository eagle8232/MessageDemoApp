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
    
    func showError(error: Error, completion: @escaping () -> Void) -> some View {
        CustomAlertView(type: .error(error)) {
            completion()
        }

    }
}
