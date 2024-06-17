//
//  CustomAnimationView.swift
//  MessageDemoApp
//
//  Created by Vusal Nuriyev 2 on 16.06.24.
//

import SwiftUI

enum CustomAnimationType {
    case bounce
}

struct CustomAnimation: ViewModifier {
    /// - The 3D rotation operates based on the familiar x and y axes we learn about in school.
    /// - Additionally, we incorporate the z-axis to achieve a three-dimensional effect.
    /// - Use this link to get better imagination of 3d rotation: https://developer.apple.com/documentation/swiftui/view/rotation3deffect(_:axis:anchor:anchorz:perspective:)
    
    // - Animation Type
    public var animationType: CustomAnimationType
    
    // - All Default Sizes from Start
    @State private(set) var xRotationDegree: CGFloat = 0
    @State private(set) var yRotationDegree: CGFloat = 0
    @State private(set) var zRotationDegree: CGFloat = 0
    
    // - Rotation Variables
    /// - Use 0's and 1's as boolean (e.g 0 is false, 1 is true)
    
    /// - X axis will rotate
    @State private(set) var xRotation: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 1, y: 0, z: 0)
    
    /// - Y axis will rotate
    @State private(set) var yRotation: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 0, y: 1, z: 0)
    
    /// - Z axis will rotate
    @State private(set) var zRotation: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 0, y: 0, z: 1)
    
    @State private var opacity: CGFloat = 1
    
    func body(content: Content) -> some View {
        switch animationType {
        case .bounce:
            bounceAnimation(content: content)
        }
    }
    
    // MARK: - Bounce Animation
    
    @State private var pressed: Bool = false
    
    @State private(set) var scaleSize: CGFloat = 1
    
    @GestureState private var isPressed = false
    
    func bounceAnimation(content: Content) -> some View {
        content
            .scaleEffect(scaleSize)
            .onTapGesture {
                /// Set any value that it is right for you
                
                /// - Duration for easeInOut, which performs that duration
                withAnimation(.easeInOut(duration: 0.2)) {
                    scaleSize = 0.9
                }
                
                /// - Stiffness determines the rigidity of the spring
                /// - Damping determines how much the spring's oscillations are reduced over time
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 15).delay(0.2)) {
                    scaleSize = 1
                }
            }
    }
}

