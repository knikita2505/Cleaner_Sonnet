//
//  NotificationPermissionView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Notification permission request screen
struct NotificationPermissionView: View {
    let onContinue: () -> Void
    let onSkip: () -> Void
    
    @State private var iconScale: CGFloat = 0.8
    @State private var bellRing = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Bell icon with ringing animation
            ZStack {
                Circle()
                    .fill(Color.lightLavender.opacity(0.2))
                    .frame(width: 140, height: 140)
                    .blur(radius: 20)
                
                Circle()
                    .fill(Color.lightLavender.opacity(0.3))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "bell.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.lightLavender)
                    .rotationEffect(.degrees(bellRing ? -15 : 15))
            }
            .scaleEffect(iconScale)
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    iconScale = 1.0
                }
                withAnimation(
                    Animation.easeInOut(duration: 0.3)
                        .repeatForever(autoreverses: true)
                ) {
                    bellRing = true
                }
            }
            
            // Title
            Text("Stay informed about\nyour device health")
                .font(.titleL)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
                .padding(.bottom, 16)
            
            // Subtitle
            Text("We send occasional reminders about cleaning your storage and helpful device tips.\n\nYou can change notification settings anytime.")
                .font(.bodyL)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 12) {
                PrimaryButton(title: "Enable Notifications") {
                    onContinue()
                }
                
                Button(action: onSkip) {
                    Text("Not now")
                        .font(.bodyM)
                        .foregroundColor(.textTertiary)
                }
            }
            .padding(.horizontal, Spacing.outer)
            .padding(.bottom, 40)
        }
    }
}

// MARK: - Preview
struct NotificationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            NotificationPermissionView(
                onContinue: {},
                onSkip: {}
            )
        }
    }
}
