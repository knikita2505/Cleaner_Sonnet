//
//  PermissionsView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Permissions flow container - 3 steps: Photos, Contacts, Notifications
struct PermissionsView: View {
    @ObservedObject var appState: AppState
    @StateObject private var permissionService = PermissionService.shared
    @State private var currentStep: PermissionStep = .photo
    @State private var showCompletionScreen = false
    
    enum PermissionStep {
        case photo
        case contacts
        case notifications
        case completed
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            if showCompletionScreen {
                // "You're all set!" screen
                completionView
            } else {
                // Permission steps
                Group {
                    switch currentStep {
                    case .photo:
                        PhotoPermissionView(onContinue: handlePhotoPermission, onSkip: skipPhotoPermission)
                    case .contacts:
                        ContactsPermissionView(onContinue: handleContactsPermission, onSkip: skipContactsPermission)
                    case .notifications:
                        NotificationPermissionView(onContinue: handleNotificationPermission, onSkip: skipNotificationPermission)
                    case .completed:
                        EmptyView()
                    }
                }
                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
    }
    
    // MARK: - Permission Handlers
    
    private func handlePhotoPermission() {
        permissionService.requestPhotoPermission { granted in
            moveToNextStep()
        }
    }
    
    private func skipPhotoPermission() {
        moveToNextStep()
    }
    
    private func handleContactsPermission() {
        permissionService.requestContactsPermission { granted in
            moveToNextStep()
        }
    }
    
    private func skipContactsPermission() {
        moveToNextStep()
    }
    
    private func handleNotificationPermission() {
        permissionService.requestNotificationPermission { granted in
            moveToNextStep()
        }
    }
    
    private func skipNotificationPermission() {
        moveToNextStep()
    }
    
    private func moveToNextStep() {
        withAnimation {
            switch currentStep {
            case .photo:
                currentStep = .contacts
            case .contacts:
                currentStep = .notifications
            case .notifications:
                // Show completion screen
                showCompletionScreen = true
                
                // After 1.5 seconds, complete permissions
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    appState.completePermissions()
                }
            case .completed:
                break
            }
        }
    }
    
    // MARK: - Completion View
    
    private var completionView: some View {
        VStack(spacing: Spacing.outer) {
            Spacer()
            
            // Checkmark animation
            ZStack {
                Circle()
                    .fill(Color.success.opacity(0.2))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.success)
            }
            .padding(.bottom, Spacing.outer)
            
            Text("You're all set!")
                .titleLStyle()
            
            Text("Let's start cleaning your device")
                .subtitleLStyle()
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .transition(.scale.combined(with: .opacity))
    }
}

// MARK: - Preview
struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView(appState: AppState())
    }
}
