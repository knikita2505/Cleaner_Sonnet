//
//  SecondaryButton.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

struct SecondaryButton: View {
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
                .font(.buttonSecondary)
                .foregroundColor(.textPrimary)
                .frame(maxWidth: .infinity)
                .frame(height: Spacing.buttonHeight)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: Spacing.buttonRadius)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1.5)
                )
        }
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.easeOut(duration: 0.2), value: isPressed)
    }
}

// MARK: - Preview
struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                SecondaryButton(title: "Skip") {
                    print("Secondary button tapped")
                }
                
                SecondaryButton(title: "Cancel") {
                    print("Cancel tapped")
                }
            }
            .padding(Spacing.outer)
        }
    }
}
