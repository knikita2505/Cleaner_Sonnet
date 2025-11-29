//
//  SubscriptionService.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import Foundation
import Combine

/// Subscription service - manages premium status and trial
/// NOTE: This is a MOCKED implementation. Real StoreKit 2 integration will be added later.
class SubscriptionService: ObservableObject {
    // MARK: - Published Properties
    
    @Published var isPremium: Bool = false
    @Published var isTrialActive: Bool = false
    @Published var trialDaysRemaining: Int = 7
    
    // MARK: - Subscription Plans
    
    enum SubscriptionPlan {
        case weekly
        case yearly
        
        var price: String {
            switch self {
            case .weekly: return "$6.99"
            case .yearly: return "$34.99"
            }
        }
        
        var period: String {
            switch self {
            case .weekly: return "week"
            case .yearly: return "year"
            }
        }
        
        var identifier: String {
            switch self {
            case .weekly: return "com.cleaner.weekly"
            case .yearly: return "com.cleaner.yearly"
            }
        }
    }
    
    // MARK: - Singleton
    
    static let shared = SubscriptionService()
    
    private init() {
        loadSubscriptionState()
    }
    
    // MARK: - Public Methods
    
    /// Start free trial
    func startTrial(completion: @escaping (Bool) -> Void) {
        // MOCK: Simulate purchase flow
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isTrialActive = true
            self.isPremium = true
            self.saveSubscriptionState()
            completion(true)
        }
    }
    
    /// Purchase subscription
    func purchase(plan: SubscriptionPlan, completion: @escaping (Bool) -> Void) {
        // MOCK: Simulate purchase flow
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isPremium = true
            self.isTrialActive = false
            self.saveSubscriptionState()
            completion(true)
        }
    }
    
    /// Restore purchases
    func restorePurchases(completion: @escaping (Bool) -> Void) {
        // MOCK: Simulate restore
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            completion(self.isPremium)
        }
    }
    
    /// Check if user has premium access
    func hasPremiumAccess() -> Bool {
        return isPremium || isTrialActive
    }
    
    // MARK: - Private Methods
    
    private func saveSubscriptionState() {
        UserDefaults.standard.set(isPremium, forKey: "isPremium")
        UserDefaults.standard.set(isTrialActive, forKey: "isTrialActive")
    }
    
    private func loadSubscriptionState() {
        isPremium = UserDefaults.standard.bool(forKey: "isPremium")
        isTrialActive = UserDefaults.standard.bool(forKey: "isTrialActive")
    }
}
