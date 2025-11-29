//
//  OnboardingStep2View.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Onboarding Step 2: Free Memory - "Удаляем ненужное. Сохраняем важное."
struct OnboardingStep2View: View {
    @State private var showDuplicateCard = false
    @State private var showLowQualityCard = false
    
    var body: some View {
        VStack(spacing: Spacing.outer) {
            Spacer()
            
            // Gallery illustration with cards
            ZStack {
                // Photo grid preview
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        photoPreviewCard(systemName: "photo", color: .primaryBlue)
                        photoPreviewCard(systemName: "photo.fill", color: .lightLavender)
                        photoPreviewCard(systemName: "photo", color: .primaryPurple)
                    }
                    HStack(spacing: 8) {
                        photoPreviewCard(systemName: "photo.fill", color: .blueGlow)
                        photoPreviewCard(systemName: "photo", color: .primaryBlue)
                        photoPreviewCard(systemName: "photo.fill", color: .lightLavender)
                    }
                }
                .opacity(0.6)
                
                // Duplicate badge
                if showDuplicateCard {
                    VStack {
                        badgeCard(text: "Duplicate", icon: "doc.on.doc.fill")
                            .offset(x: -40, y: -60)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
                
                // Low quality badge
                if showLowQualityCard {
                    VStack {
                        badgeCard(text: "Low Quality", icon: "exclamationmark.triangle.fill")
                            .offset(x: 50, y: 40)
                            .transition(.scale.combined(with: .opacity))
                    }
                }
            }
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(.easeOut(duration: 0.4).delay(0.3)) {
                    showDuplicateCard = true
                }
                withAnimation(.easeOut(duration: 0.4).delay(0.6)) {
                    showLowQualityCard = true
                }
            }
            
            // Title
            Text("Удаляем ненужное.\nСохраняем важное.")
                .font(.titleL)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            // Subtitle
            Text("Точно находим дубликаты, похожие фото,\nLive и размытые кадры. Вы решаете, что оставить.")
                .font(.bodyL)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            Spacer()
        }
    }
    
    // MARK: - Helper Views
    
    private func photoPreviewCard(systemName: String, color: Color) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color.opacity(0.3))
            .frame(width: 80, height: 80)
            .overlay(
                Image(systemName: systemName)
                    .font(.system(size: 30))
                    .foregroundColor(color)
            )
    }
    
    private func badgeCard(text: String, icon: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 14))
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(Color.warning)
        )
        .softShadowSmall()
    }
}

// MARK: - Preview
struct OnboardingStep2View_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.auroraGradient
                .ignoresSafeArea()
            OnboardingStep2View()
        }
    }
}
