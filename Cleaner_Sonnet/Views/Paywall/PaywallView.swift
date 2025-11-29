//
//  PaywallView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Main paywall screen with trial and subscription options
struct PaywallView: View {
    @ObservedObject var appState: AppState
    @StateObject private var subscriptionService = SubscriptionService.shared
    
    @State private var selectedPlan: SubscriptionService.SubscriptionPlan = .yearly
    @State private var trialEnabled = true
    @State private var isPurchasing = false
    
    var body: some View {
        ZStack {
            // Aurora gradient background
            Color.auroraGradient
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top section - Skip button
                HStack {
                    Spacer()
                    Button(action: skipPaywall) {
                        Text("Skip for now")
                            .font(.bodyM)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                    }
                }
                .padding(.top, 16)
                
                ScrollView {
                    VStack(spacing: Spacing.outer) {
                        // App icon and title
                        VStack(spacing: 16) {
                            // App icon placeholder
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "sparkles")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            Text("Clean up your iPhone\nfast & easy")
                                .font(.titleL)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 20)
                        
                        // Feature list
                        VStack(alignment: .leading, spacing: 12) {
                            featureRow(icon: "photo.on.rectangle.angled", text: "Remove duplicate photos & videos")
                            featureRow(icon: "video.badge.checkmark", text: "Compress large videos")
                            featureRow(icon: "lock.shield.fill", text: "Secret album protection")
                            featureRow(icon: "battery.100", text: "Battery & device health tips")
                        }
                        .padding(.vertical, 20)
                        
                        // Trial toggle (if enabled)
                        if trialEnabled {
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.warning)
                                
                                Text("7 days free, then \(selectedPlan.price)/\(selectedPlan.period)")
                                    .font(.subtitleM)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.15))
                            )
                        }
                        
                        // Plan selection
                        VStack(spacing: 12) {
                            planCard(
                                plan: .yearly,
                                badge: "Most popular",
                                savings: "Save 70%"
                            )
                            
                            planCard(
                                plan: .weekly,
                                badge: nil,
                                savings: nil
                            )
                        }
                        
                        // Benefits list
                        VStack(alignment: .leading, spacing: 8) {
                            benefitRow(text: "No ads or interruptions")
                            benefitRow(text: "Full access to all features")
                            benefitRow(text: "Priority support")
                        }
                        .padding(.vertical, 12)
                    }
                    .padding(.horizontal, Spacing.outer)
                }
                
                // Bottom CTA
                VStack(spacing: 12) {
                    PrimaryButton(title: trialEnabled ? "Try for Free" : "Continue") {
                        purchaseSubscription()
                    }
                    .disabled(isPurchasing)
                    .opacity(isPurchasing ? 0.6 : 1.0)
                    
                    // Terms and privacy
                    HStack(spacing: 4) {
                        Text("Terms")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.4))
                        
                        Text("•")
                            .foregroundColor(.white.opacity(0.4))
                        
                        Text("Privacy")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.4))
                        
                        Text("•")
                            .foregroundColor(.white.opacity(0.4))
                        
                        Button("Restore") {
                            restorePurchases()
                        }
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))
                    }
                }
                .padding(.horizontal, Spacing.outer)
                .padding(.bottom, 40)
            }
            
            // Loading overlay
            if isPurchasing {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
            }
        }
    }
    
    // MARK: - Helper Views
    
    private func featureRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.primaryBlue)
                .frame(width: 28)
            
            Text(text)
                .font(.bodyL)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
    
    private func planCard(plan: SubscriptionService.SubscriptionPlan, badge: String?, savings: String?) -> some View {
        Button {
            withAnimation {
                selectedPlan = plan
            }
        } label: {
            HStack {
                // Radio button
                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if selectedPlan == plan {
                        Circle()
                            .fill(Color.primaryBlue)
                            .frame(width: 14, height: 14)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(plan == .yearly ? "Yearly Plan" : "Weekly Plan")
                            .font(.subtitleM)
                            .foregroundColor(.white)
                        
                        if let badge = badge {
                            Text(badge)
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(Color.warning)
                                )
                        }
                    }
                    
                    HStack {
                        Text(plan.price)
                            .font(.titleM)
                            .foregroundColor(.white)
                        
                        Text("/\(plan.period)")
                            .font(.bodyM)
                            .foregroundColor(.white.opacity(0.7))
                        
                        if let savings = savings {
                            Text(savings)
                                .font(.caption)
                                .foregroundColor(.success)
                        }
                    }
                }
                
                Spacer()
            }
            .padding(Spacing.inner)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(selectedPlan == plan ? Color.white.opacity(0.2) : Color.white.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selectedPlan == plan ? Color.primaryBlue : Color.clear, lineWidth: 2)
            )
        }
    }
    
    private func benefitRow(text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 16))
                .foregroundColor(.success)
            
            Text(text)
                .font(.bodyM)
                .foregroundColor(.white.opacity(0.8))
            
            Spacer()
        }
    }
    
    // MARK: - Actions
    
    private func purchaseSubscription() {
        isPurchasing = true
        
        if trialEnabled {
            subscriptionService.startTrial { success in
                isPurchasing = false
                if success {
                    appState.completePaywall(premium: true)
                }
            }
        } else {
            subscriptionService.purchase(plan: selectedPlan) { success in
                isPurchasing = false
                if success {
                    appState.completePaywall(premium: true)
                }
            }
        }
    }
    
    private func skipPaywall() {
        appState.completePaywall(premium: false)
    }
    
    private func restorePurchases() {
        isPurchasing = true
        subscriptionService.restorePurchases { success in
            isPurchasing = false
            if success {
                appState.completePaywall(premium: true)
            }
        }
    }
}

// MARK: - Preview
struct PaywallView_Previews: PreviewProvider {
    static var previews: some View {
        PaywallView(appState: AppState())
    }
}
