//
//  CustomTextField.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 14.06.24.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let title: String? = nil
    var placeholder: String?
    let isSecure: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.title)
            }
            
            Group {
                if isSecure {
                    SecureField(placeholder ?? "", text: $text)
                } else {
                    TextField(placeholder ?? "", text: $text)
                }
            }
            .padding(10)
            .background {
                CustomBlurView(style: .extraLight)
                    .clipShape(Capsule())
            }
        }
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
    }
    
}
