//
//  DashboardView.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var appState: AppState
    var body: some View {
        ZStack {
            // Premium dark background
            Color.primaryBackground
                .ignoresSafeArea()
            
            VStack(spacing: Spacing.outer) {
                Spacer()
                
                // App Icon Placeholder
                Image(systemName: "sparkles")
                    .font(.system(size: 80))
                    .foregroundColor(.primaryBlue)
                    .padding(.bottom, Spacing.inner)
                
                // Title
                Text("iOS Cleaner")
                    .titleXLStyle()
                
                // Subtitle
                Text("Premium cleaning utility")
                    .subtitleLStyle()
                    .padding(.bottom, Spacing.outer)
                
                Spacer()
                
                // Demo Cards
                VStack(spacing: Spacing.betweenBlocks) {
                    PrimaryCard {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: Spacing.iconMedium))
                                .foregroundColor(.primaryBlue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Photo Cleaner")
                                    .subtitleMStyle()
                                
                                Text("Remove duplicates & similar photos")
                                    .bodyMStyle()
                            }
                            
                            Spacer()
                        }
                    }
                    
                    PrimaryCard {
                        HStack {
                            Image(systemName: "video.badge.checkmark")
                                .font(.system(size: Spacing.iconMedium))
                                .foregroundColor(.primaryPurple)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Video Compression")
                                    .subtitleMStyle()
                                
                                Text("Save storage space")
                                    .bodyMStyle()
                            }
                            
                            Spacer()
                        }
                    }
                }
                
                Spacer()
                
                // Demo Buttons
                VStack(spacing: Spacing.betweenBlocks) {
                    PrimaryButton(title: "Get Started") {
                        print("Get Started tapped")
                    }
                    
                    SecondaryButton(title: "Learn More") {
                        print("Learn More tapped")
                    }
                }
            }
            .padding(Spacing.outer)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(appState: AppState())
    }
}
