//
//  Cleaner_SonnetApp.swift
//  Cleaner_Sonnet
//
//  Created by Nikita on 29.11.2025.
//

import SwiftUI

@main
struct Cleaner_SonnetApp: App {
    var body: some Scene {
        WindowGroup {
            AppRouter()
                .preferredColorScheme(.dark)
        }
    }
}
