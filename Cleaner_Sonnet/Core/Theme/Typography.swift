//
//  Typography.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

// MARK: - Typography System
extension Font {
    // MARK: - Titles
    /// Title XL - 32pt Bold
    static let titleXL = Font.system(size: 32, weight: .bold, design: .default)
    
    /// Title L - 28pt Bold
    static let titleL = Font.system(size: 28, weight: .bold, design: .default)
    
    /// Title M - 24pt Semibold
    static let titleM = Font.system(size: 24, weight: .semibold, design: .default)
    
    // MARK: - Subtitles
    /// Subtitle L - 18pt Medium
    static let subtitleL = Font.system(size: 18, weight: .medium, design: .default)
    
    /// Subtitle M - 16pt Medium
    static let subtitleM = Font.system(size: 16, weight: .medium, design: .default)
    
    // MARK: - Body Text
    /// Body L - 16pt Regular
    static let bodyL = Font.system(size: 16, weight: .regular, design: .default)
    
    /// Body M - 14pt Regular
    static let bodyM = Font.system(size: 14, weight: .regular, design: .default)
    
    /// Caption - 12pt Regular
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
    
    // MARK: - Button Text
    /// Primary button text - 18pt Medium
    static let buttonPrimary = Font.system(size: 18, weight: .medium, design: .default)
    
    /// Secondary button text - 16pt Medium
    static let buttonSecondary = Font.system(size: 16, weight: .medium, design: .default)
}

// MARK: - Text Style Modifiers
extension View {
    /// Apply title XL style with primary color
    func titleXLStyle() -> some View {
        self
            .font(.titleXL)
            .foregroundColor(.textPrimary)
    }
    
    /// Apply title L style with primary color
    func titleLStyle() -> some View {
        self
            .font(.titleL)
            .foregroundColor(.textPrimary)
    }
    
    /// Apply title M style with primary color
    func titleMStyle() -> some View {
        self
            .font(.titleM)
            .foregroundColor(.textPrimary)
    }
    
    /// Apply subtitle L style with secondary color
    func subtitleLStyle() -> some View {
        self
            .font(.subtitleL)
            .foregroundColor(.textSecondary)
    }
    
    /// Apply subtitle M style with secondary color
    func subtitleMStyle() -> some View {
        self
            .font(.subtitleM)
            .foregroundColor(.textSecondary)
    }
    
    /// Apply body L style
    func bodyLStyle() -> some View {
        self
            .font(.bodyL)
            .foregroundColor(.textSecondary)
    }
    
    /// Apply body M style
    func bodyMStyle() -> some View {
        self
            .font(.bodyM)
            .foregroundColor(.textSecondary)
    }
    
    /// Apply caption style with tertiary color and 60% opacity
    func captionStyle() -> some View {
        self
            .font(.caption)
            .foregroundColor(.textTertiary)
            .opacity(0.6)
    }
}
