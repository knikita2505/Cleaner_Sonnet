//
//  ContactsPermissionView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Contacts permission request screen
struct ContactsPermissionView: View {
    let onContinue: () -> Void
    let onSkip: () -> Void
    
    @State private var iconScale: CGFloat = 0.8
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            // Large contacts icon with blur effect
            ZStack {
                Circle()
                    .fill(Color.primaryPurple.opacity(0.2))
                    .frame(width: 140, height: 140)
                    .blur(radius: 20)
                
                Circle()
                    .fill(Color.primaryPurple.opacity(0.3))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "person.2.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.primaryPurple)
            }
            .scaleEffect(iconScale)
            .padding(.bottom, 40)
            .onAppear {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    iconScale = 1.0
                }
            }
            
            // Title
            Text("Allow access to your Contacts")
                .font(.titleL)
                .foregroundColor(.textPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.outer)
                .padding(.bottom, 16)
            
            // Use cases list
            VStack(alignment: .leading, spacing: 12) {
                Text("We use contacts access to:")
                    .font(.bodyL)
                    .foregroundColor(.textSecondary)
                
                featureRow(icon: "arrow.triangle.merge", text: "Find and merge duplicate contacts")
                featureRow(icon: "trash", text: "Clean empty or outdated entries")
                featureRow(icon: "lock.shield", text: "Enable the \"Secret Contacts\" feature")
            }
            .padding(.horizontal, Spacing.outer)
            .padding(.bottom, 24)
            
            // Safety note
            HStack(spacing: 8) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 16))
                    .foregroundColor(.success)
                
                Text("We never upload your contacts. All processing happens locally on your device.")
                    .font(.caption)
                    .foregroundColor(.textTertiary)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, Spacing.outer)
            
            Spacer()
            
            // Buttons
            VStack(spacing: 12) {
                PrimaryButton(title: "Allow Contacts Access") {
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
    
    // MARK: - Helper Views
    
    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(.primaryPurple)
                .frame(width: 24)
            
            Text(text)
                .font(.bodyM)
                .foregroundColor(.textSecondary)
            
            Spacer()
        }
    }
}

// MARK: - Preview
struct ContactsPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            ContactsPermissionView(
                onContinue: {},
                onSkip: {}
            )
        }
    }
}
