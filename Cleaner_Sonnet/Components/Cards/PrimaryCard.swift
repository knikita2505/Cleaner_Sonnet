//
//  PrimaryCard.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

struct PrimaryCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(Spacing.inner)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.secondaryBackground)
            .cornerRadius(Spacing.cardRadius)
            .softShadow()
    }
}

// MARK: - Preview
struct PrimaryCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                PrimaryCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: Spacing.iconMedium))
                                .foregroundColor(.primaryBlue)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                                .foregroundColor(.textTertiary)
                        }
                        
                        Text("Similar Photos")
                            .titleMStyle()
                        
                        Text("124 duplicates found")
                            .bodyMStyle()
                    }
                }
                
                PrimaryCard {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Storage Info")
                            .subtitleLStyle()
                        
                        HStack {
                            Text("Used: 45.2 GB")
                                .bodyLStyle()
                            Spacer()
                            Text("Free: 18.8 GB")
                                .bodyLStyle()
                        }
                    }
                }
            }
            .padding(Spacing.outer)
        }
    }
}
