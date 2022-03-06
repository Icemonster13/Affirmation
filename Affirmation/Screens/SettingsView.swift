//
//  SettingsView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/26/22.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    
    // Access the UserDefaults
    @AppStorage("onboard") var isOnboardingViewActive: Bool = false
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = true
    @AppStorage("highscore") var highScore = 0
    @AppStorage("totalwords") var totalWords = 0
    @AppStorage("soundenabled") private var isSoundEnabled: Bool = true
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack {
                Text("Settings")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.all, 0.0)
                    .background(Color("ColorFormBackground"))
                
                Form {
                    
                    // MARK: - APPLICATION SECTIONS
                    
                    Section(header: Text("Affirmation")) {
                        VStack {
                            Text("A word game where you list as many words as you can from the given affirmation or phrase. Inspired by my beautiful wife, this project allowed me to learn SwiftUI while designing one of her favorite games.")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Text("Let it inspire you!")
                                .font(.callout)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                                .padding()
                        } //: VSTACK
                        .padding(10)
                    } //: SECTION
                    
                    // MARK: - SETTING SECTION
                    Section(header: Text("Settings")) {
                        VStack {
                            HStack {
                                FormSettingRowView(icon: "speaker.wave.3", firsttext: "Sound Effects")
                                Toggle("Turn sound on or off", isOn: $isSoundEnabled)
                                    .labelsHidden()
                            } //: HSTACK
                            HStack {
                                FormSettingRowView(icon: "rosette", firsttext: "High Score")
                                Text(String(highScore))
                                    .font(.footnote)
                            } //: HSTACK
                            HStack {
                                FormSettingRowView(icon: "textformat.abc.dottedunderline", firsttext: "Total Words Played")
                                Text(String(totalWords))
                                    .font(.footnote)
                            } //: HSTACK
                            Button(action: {
                                // Reset the UserDefaults for 'highscore' and 'totalwords'
                                highScore = 0
                                totalWords = 0
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                    .imageScale(.large)
                                Text("Reset All Statistics")
                                    .font(.system(.subheadline, design: .rounded))
                                    .fontWeight(.bold)
                            } //: BUTTON
                            .tint(Color.blue)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .controlSize(.regular)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    } //: SECTION
                    
                    // MARK: - ABOUT SECTION
                    Section(header: Text("About the application")) {
                        VStack {
                            FormAboutRowView(icon: "scribble.variable", firstText: "Application", secondText: "Affirmation", fillColor: Color.blue)
                            FormAboutRowView(icon: "wrench.and.screwdriver", firstText: "Designer", secondText: "Michael Pascucci", fillColor: Color.green)
                            FormAboutRowView(icon: "gearshape", firstText: "Compatibility", secondText: "iPhone / iPad", fillColor: Color.orange)
                            FormAboutRowView(icon: "exclamationmark.shield", firstText: "Version", secondText: "1.0.0", fillColor: Color.yellow)
                        } //: VSTACK
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    } //: SECTION
                } //: FORM
                
                // MARK: - FOOTER
                Text("Copyright ©️ All rights reserved")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //: END VSTACK
        } //: ZSTACK
        .background(Color("ColorFormBackground"))
        .overlay(
            Button(action: {
                isPuzzleViewActive = true
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.trailing, 4)
            })
            , alignment: .topTrailing
        )
    } //: VIEW
} //: STRUCT

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
