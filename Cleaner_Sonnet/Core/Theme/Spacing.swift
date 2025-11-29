//
//  Spacing.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

// MARK: - Spacing System
enum Spacing {
    // MARK: - Padding
    /// Outer padding - 24pt
    static let outer: CGFloat = 24
    
    /// Outer padding alternative - 20pt
    static let outerSmall: CGFloat = 20
    
    /// Inner padding in containers - 20pt
    static let inner: CGFloat = 20
    
    /// Inner padding alternative - 16pt
    static let innerSmall: CGFloat = 16
    
    /// Between blocks - 16pt
    static let betweenBlocks: CGFloat = 16
    
    /// Between icon and text - 12pt
    static let iconText: CGFloat = 12
    
    /// Small spacing - 8pt
    static let small: CGFloat = 8
    
    /// Extra small spacing - 4pt
    static let extraSmall: CGFloat = 4
    
    // MARK: - Corner Radius
    /// Cards corner radius - 20pt
    static let cardRadius: CGFloat = 20
    
    /// Buttons corner radius - 16pt
    static let buttonRadius: CGFloat = 16
    
    /// Buttons corner radius alternative - 20pt
    static let buttonRadiusLarge: CGFloat = 20
    
    /// Modals corner radius - 32pt
    static let modalRadius: CGFloat = 32
    
    // MARK: - Heights
    /// Primary button height - 56pt
    static let buttonHeight: CGFloat = 56
    
    /// List card height - 72pt
    static let listCardHeightSmall: CGFloat = 72
    
    /// List card height alternative - 80pt
    static let listCardHeightLarge: CGFloat = 80
    
    /// Progress bar height - 8pt
    static let progressBarHeight: CGFloat = 8
    
    // MARK: - Icon Sizes
    /// Small icon size - 24pt
    static let iconSmall: CGFloat = 24
    
    /// Medium icon size - 32pt
    static let iconMedium: CGFloat = 32
    
    /// Large icon size - 36-44pt
    static let iconLarge: CGFloat = 40
    
    /// Extra large icon (permissions, onboarding) - 80pt
    static let iconExtraLarge: CGFloat = 80
    
    // MARK: - Shadow
    /// Shadow blur radius - 12pt
    static let shadowBlur: CGFloat = 12
    
    /// Shadow blur radius alternative - 8pt
    static let shadowBlurSmall: CGFloat = 8
}

// MARK: - Shadow Modifier
extension View {
    /// Apply soft shadow as per design spec
    func softShadow() -> some View {
        self.shadow(
            color: Color.black.opacity(0.3),
            radius: Spacing.shadowBlur,
            x: 0,
            y: 4
        )
    }
    
    /// Apply small soft shadow
    func softShadowSmall() -> some View {
        self.shadow(
            color: Color.black.opacity(0.3),
            radius: Spacing.shadowBlurSmall,
            x: 0,
            y: 2
        )
    }
}
