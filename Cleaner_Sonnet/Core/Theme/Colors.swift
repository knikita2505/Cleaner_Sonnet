//
//  Colors.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

extension Color {
    // MARK: - Background Colors
    /// Deep dark blue - Primary background (#0D0F16)
    static let primaryBackground = Color(hex: "0D0F16")
    
    /// Graphite - Secondary background for working screens (#111214)
    static let secondaryBackground = Color(hex: "111214")
    
    /// Card background (#121317)
    static let cardBackground = Color(hex: "121317")
    
    /// Modal background (#0F1116)
    static let modalBackground = Color(hex: "0F1116")
    
    // MARK: - Accent Colors
    /// Primary blue accent (#3B5BFF)
    static let primaryBlue = Color(hex: "3B5BFF")
    
    /// Purple accent (#7A4DFB)
    static let primaryPurple = Color(hex: "7A4DFB")
    
    /// Light lavender (#A88CFF)
    static let lightLavender = Color(hex: "A88CFF")
    
    /// Blue glow (#7FB9FF)
    static let blueGlow = Color(hex: "7FB9FF")
    
    // MARK: - Text Colors
    /// Primary text - White for bold headers (#FFFFFF)
    static let textPrimary = Color.white
    
    /// Secondary text - Light for descriptions (#E6E8ED)
    static let textSecondary = Color(hex: "E6E8ED")
    
    /// Tertiary text - System texts (#AEB4BE)
    static let textTertiary = Color(hex: "AEB4BE")
    
    // MARK: - Status Colors
    /// Success color (#41D3B3)
    static let success = Color(hex: "41D3B3")
    
    /// Warning color (#FFB84D)
    static let warning = Color(hex: "FFB84D")
    
    /// Error color (#FF4D4D)
    static let error = Color(hex: "FF4D4D")
    
    // MARK: - Gradients
    /// CTA Gradient - Primary action gradient
    static let ctaGradient = LinearGradient(
        colors: [Color.primaryBlue, Color.primaryPurple],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    /// Aurora Gradient - For onboarding and paywalls
    static let auroraGradient = LinearGradient(
        colors: [
            Color(hex: "2F3DAF"),
            Color(hex: "6B3BDB"),
            Color(hex: "8B5CFF")
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    /// Storage indicator gradient (orange to yellow)
    static let storageGradient = LinearGradient(
        colors: [
            Color(hex: "FF8D4D"),
            Color(hex: "FFD36B")
        ],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// MARK: - Hex Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
