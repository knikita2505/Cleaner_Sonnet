//
//  PhotoPermissionView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Photo permission request screen
struct PhotoPermissionView: View {
    let onContinue: () -> Void
    let onSkip: () -> Void
    
    @State private var iconScale: CGFloat = 0.8
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Large photo icon with blur effect
            ZStack {
                Circle()
                    .fill(Color.primaryBlue.opacity(0.2))
                    .frame(width: 140, height: 140)
                    .blur(radius: 20)
                
                Circle()
                    .fill(Color.primaryBlue.opacity(0.3))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 50))
                    .foregroundColor(.primaryBlue)
            }
            .scaleEffect(iconScale)
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    iconScale = 1.0
                }
            }
            
            // Title
            Text("Allow access to your Photos")
                .font(.titleL)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
                .padding(.bottom, 16)
            
            // Subtitle
            Text("We need this to detect duplicates, similar photos, live photos, screenshots and large videos to free up your storage space.")
                .font(.bodyL)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
                .padding(.bottom, 24)
            
            // Safety note
            HStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.success)
                
                Text("Your photos are analyzed only on your device. We never upload your media anywhere.")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, Spacing.outer)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 12) {
                PrimaryButton(title: "Continue") {
                    onContinue()
                }
                
                Button(action: onSkip) {
                    Text("Skip for now")
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
struct PhotoPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            PhotoPermissionView(
                onContinue: {},
                onSkip: {}
            )
        }
    }
}
