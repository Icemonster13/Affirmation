//
//  AffirmationApp.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/14/22.
//

import SwiftUI

@main
struct AffirmationApp: App {
    
    // MARK: - PROPERTIES
    @AppStorage("darkmodeenabled") private var isDarkModeEnabled: Bool = false
    @AppStorage("home") var isHomeViewActive: Bool = true
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = false
    
    @Environment(\.scenePhase) private var scenePhase
    
    // MARK: - BODY
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                isHomeViewActive = true
                isPuzzleViewActive = false
                isSettingViewActive = false
            default:
                print("something new added by apple")
            }
        }
    }
}
