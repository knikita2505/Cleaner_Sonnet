//
//  OnboardingStep1View.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Onboarding Step 1: Welcome - "Давайте наведём порядок на вашем устройстве"
struct OnboardingStep1View: View {
    @State private var animate = false
    
    var body: some View {
        VStack(spacing: Spacing.outer) {
            Spacer()
            
            // Animated circle - symbol of cleanliness
            ZStack {
                // Outer glow circles
                Circle()
                    .fill(Color.primaryBlue.opacity(0.3))
                    .frame(width: 200, height: 200)
                    .scaleEffect(animate ? 1.2 : 1.0)
                    .opacity(animate ? 0.0 : 0.5)
                
                Circle()
                    .fill(Color.primaryPurple.opacity(0.4))
                    .frame(width: 160, height: 160)
                    .scaleEffect(animate ? 1.15 : 1.0)
                    .opacity(animate ? 0.0 : 0.6)
                
                // Main icon
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.primaryBlue, Color.primaryPurple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 120, height: 120)
                
                Image(systemName: "sparkles")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: false)
                ) {
                    animate = true
                }
            }
            
            // Title
            Text("Давайте наведём порядок\nна вашем устройстве")
                .font(.titleL)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            // Subtitle
            Text("Умное сканирование фото, видео,\nдубликатов и системного захламления.")
                .font(.bodyL)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            Spacer()
        }
    }
}

// MARK: - Preview
struct OnboardingStep1View_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.auroraGradient
                .ignoresSafeArea()
            OnboardingStep1View()
        }
    }
}
