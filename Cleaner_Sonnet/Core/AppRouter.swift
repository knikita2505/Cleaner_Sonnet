//
//  AppRouter.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Main navigation coordinator - determines which screen to show based on app state
struct AppRouter: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        Group {
            if !appState.hasSeenOnboarding {
                // First launch - show onboarding
                OnboardingView(appState: appState)
            } else if !appState.hasCompletedPermissions {
                // After onboarding - show permissions
                PermissionsView(appState: appState)
            } else if !appState.isPremium {
                // Show paywall until user purchases subscription
                // This will show on every launch until isPremium = true
                PaywallView(appState: appState)
            } else {
                // User has premium - show main app
                DashboardView(appState: appState)
            }
        }
    }
}

// MARK: - Preview
struct AppRouter_Previews: PreviewProvider {
    static var previews: some View {
        AppRouter()
    }
}
