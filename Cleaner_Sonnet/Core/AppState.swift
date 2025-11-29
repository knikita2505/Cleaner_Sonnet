//
//  AppState.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import Foundation
import Combine

/// Global app state manager - tracks user progress through onboarding, permissions, and subscription
class AppState: ObservableObject {
    // MARK: - Published Properties
    
    /// User has completed onboarding flow
    @Published var hasSeenOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(hasSeenOnboarding, forKey: "hasSeenOnboarding")
        }
    }
    
    /// User has completed permissions flow
    @Published var hasCompletedPermissions: Bool {
        didSet {
            UserDefaults.standard.set(hasCompletedPermissions, forKey: "hasCompletedPermissions")
        }
    }
    
    /// User has seen the paywall (skipped or purchased)
    @Published var hasSeenPaywall: Bool {
        didSet {
            UserDefaults.standard.set(hasSeenPaywall, forKey: "hasSeenPaywall")
        }
    }
    
    /// User has premium subscription
    @Published var isPremium: Bool {
        didSet {
            UserDefaults.standard.set(isPremium, forKey: "isPremium")
        }
    }
    
    // MARK: - Initialization
    
    init() {
        // Load saved state from UserDefaults
        self.hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        self.hasCompletedPermissions = UserDefaults.standard.bool(forKey: "hasCompletedPermissions")
        self.hasSeenPaywall = UserDefaults.standard.bool(forKey: "hasSeenPaywall")
        self.isPremium = UserDefaults.standard.bool(forKey: "isPremium")
    }
    
    // MARK: - Public Methods
    
    /// Complete onboarding and move to permissions
    func completeOnboarding() {
        hasSeenOnboarding = true
    }
    
    /// Complete permissions and move to paywall
    func completePermissions() {
        hasCompletedPermissions = true
    }
    
    /// Complete paywall (skipped or purchased)
    func completePaywall(premium: Bool = false) {
        hasSeenPaywall = true
        if premium {
            isPremium = true
        }
    }
    
    /// Reset all state (for testing)
    func resetAppState() {
        hasSeenOnboarding = false
        hasCompletedPermissions = false
        hasSeenPaywall = false
        isPremium = false
    }
}
