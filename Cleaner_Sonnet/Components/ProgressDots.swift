//
//  ProgressDots.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

/// Progress indicator dots for onboarding screens
struct ProgressDots: View {
    let totalSteps: Int
    let currentStep: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Circle()
                    .fill(index == currentStep ? Color.primaryBlue : Color.white.opacity(0.3))
                    .frame(width: 8, height: 8)
                    .animation(.easeOut(duration: 0.3), value: currentStep)
            }
        }
    }
}

// MARK: - Preview
struct ProgressDots_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressDots(totalSteps: 4, currentStep: 0)
                ProgressDots(totalSteps: 4, currentStep: 1)
                ProgressDots(totalSteps: 4, currentStep: 2)
                ProgressDots(totalSteps: 4, currentStep: 3)
            }
        }
    }
}
