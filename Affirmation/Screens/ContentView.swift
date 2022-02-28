//
//  ContentView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    @AppStorage("onboard") var isOnboardingViewActive: Bool = true
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = false
    
    // MARK: - BODY
    var body: some View {
        
        ZStack {
            if isOnboardingViewActive {
                OnboardingView()
            } else if isPuzzleViewActive {
                PuzzleView()
            } else if isSettingViewActive {
                SettingsView()
            } else {
                HomeView()
            }
        } //: ZSTACK
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
