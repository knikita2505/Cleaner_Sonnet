//
//  OnboardingStep4View.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Onboarding Step 4: Premium Quality - "Разработано для стабильной и безопасной работы"
struct OnboardingStep4View: View {
    @State private var shimmerOffset: CGFloat = -200
    
    var body: some View {
        VStack(spacing: Spacing.outer) {
            Spacer()
            
            // Premium quality card with shimmer effect
            ZStack {
                // Main gradient card
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.primaryBlue.opacity(0.3),
                                Color.primaryPurple.opacity(0.3)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 280, height: 160)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.3), Color.white.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                
                // Shimmer effect
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.clear,
                                Color.white.opacity(0.3),
                                Color.clear
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 100, height: 160)
                    .offset(x: shimmerOffset)
                    .mask(
                        RoundedRectangle(cornerRadius: 24)
                            .frame(width: 280, height: 160)
                    )
                
                // Content
                VStack(spacing: 12) {
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                    
                    Text("Premium Quality")
                        .font(.titleM)
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 2.5)
                        .repeatForever(autoreverses: false)
                ) {
                    shimmerOffset = 300
                }
            }
            
            // Title
            Text("Разработано для стабильной\nи безопасной работы")
                .font(.titleL)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            // Subtitle
            Text("Ваши данные остаются на устройстве.\nМы не отправляем фото или видео на сервер.")
                .font(.bodyL)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            Spacer()
        }
    }
}

// MARK: - Preview
struct OnboardingStep4View_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.auroraGradient
                .ignoresSafeArea()
            OnboardingStep4View()
        }
    }
}
