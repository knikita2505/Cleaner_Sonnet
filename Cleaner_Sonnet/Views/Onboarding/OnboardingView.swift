//
//  OnboardingView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Main onboarding container with 4 steps
struct OnboardingView: View {
    @ObservedObject var appState: AppState
    @State private var currentStep = 0
    
    private let totalSteps = 4
    
    var body: some View {
        ZStack {
            // Aurora gradient background
            Color.auroraGradient
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress indicator
                ProgressDots(totalSteps: totalSteps, currentStep: currentStep)
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                
                // Content area with TabView for swipeable pages
                TabView(selection: $currentStep) {
                    OnboardingStep1View()
                        .tag(0)
                    
                    OnboardingStep2View()
                        .tag(1)
                    
                    OnboardingStep3View()
                        .tag(2)
                    
                    OnboardingStep4View()
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Bottom button
                PrimaryButton(title: currentStep == totalSteps - 1 ? "Get Started" : "Continue") {
                    if currentStep < totalSteps - 1 {
                        withAnimation {
                            currentStep += 1
                        }
                    } else {
                        // Complete onboarding
                        appState.completeOnboarding()
                    }
                }
                .padding(.horizontal, Spacing.outer)
                .padding(.bottom, 40)
            }
        }
    }
}

// MARK: - Preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(appState: AppState())
    }
}
