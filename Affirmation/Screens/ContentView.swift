//
//  ContentView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    // Access the UserDefaults data
    @AppStorage("home") var isHomeViewActive: Bool = true
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = false
    
    // MARK: - BODY
    var body: some View {
        
        if isPuzzleViewActive {
            PuzzleView()
        } else if isSettingViewActive {
            SettingsView()
        } else {
            HomeView()
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
