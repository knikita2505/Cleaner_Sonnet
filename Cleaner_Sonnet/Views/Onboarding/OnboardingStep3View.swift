//
//  OnboardingStep3View.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Onboarding Step 3: Performance - "Максимальная производительность каждый день"
struct OnboardingStep3View: View {
    @State private var showBattery = false
    @State private var showStorage = false
    @State private var showSpeed = false
    
    var body: some View {
        VStack(spacing: Spacing.outer) {
            Spacer()
            
            // Performance indicators
            VStack(spacing: 24) {
                if showBattery {
                    performanceIndicator(
                        icon: "battery.100",
                        title: "Battery Health",
                        value: "95%",
                        color: .success
                    )
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                }
                
                if showStorage {
                    performanceIndicator(
                        icon: "internaldrive",
                        title: "Storage Optimized",
                        value: "18.2 GB Free",
                        color: .primaryBlue
                    )
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                }
                
                if showSpeed {
                    performanceIndicator(
                        icon: "speedometer",
                        title: "Device Performance",
                        value: "Optimal",
                        color: .lightLavender
                    )
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
                }
            }
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(.easeOut(duration: 0.35).delay(0.2)) {
                    showBattery = true
                }
                withAnimation(.easeOut(duration: 0.35).delay(0.4)) {
                    showStorage = true
                }
                withAnimation(.easeOut(duration: 0.35).delay(0.6)) {
                    showSpeed = true
                }
            }
            
            // Title
            Text("Максимальная производительность\nкаждый день")
                .font(.titleL)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            // Subtitle
            Text("Умный анализ устройства: состояние батареи,\nнагрев, тяжёлые файлы — всё под контролем.")
                .font(.bodyL)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            Spacer()
        }
    }
    
    // MARK: - Helper Views
    
    private func performanceIndicator(icon: String, title: String, value: String, color: Color) -> some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 60, height: 60)
                
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(color)
            }
            
            // Text
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subtitleM)
                    .foregroundColor(.white)
                
                Text(value)
                    .font(.bodyM)
                    .foregroundColor(.white.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(Spacing.inner)
        .background(
            RoundedRectangle(cornerRadius: Spacing.cardRadius)
                .fill(Color.white.opacity(0.1))
        )
        .padding(.horizontal, Spacing.outer)
    }
}

// MARK: - Preview
struct OnboardingStep3View_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.auroraGradient
                .ignoresSafeArea()
            OnboardingStep3View()
        }
    }
}
