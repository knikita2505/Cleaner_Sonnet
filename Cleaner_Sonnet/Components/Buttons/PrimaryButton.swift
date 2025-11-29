//
//  PrimaryButton.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.easeOut(duration: 0.1)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.1)) {
                    isPressed = false
                }
                action()
            }
        }) {
            Text(title)
                .font(.buttonPrimary)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: Spacing.buttonHeight)
                .background(Color.ctaGradient)
                .cornerRadius(Spacing.buttonRadius)
                .softShadow()
        }
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.easeOut(duration: 0.2), value: isPressed)
    }
}

// MARK: - Preview
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                PrimaryButton(title: "Continue") {
                    print("Primary button tapped")
                }
                
                PrimaryButton(title: "Start Cleaning") {
                    print("Start cleaning tapped")
                }
            }
            .padding(Spacing.outer)
        }
    }
}
