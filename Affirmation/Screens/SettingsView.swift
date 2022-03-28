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
    @AppStorage("highwords") var highWords = 0
    @AppStorage("soundenabled") private var isSoundEnabled: Bool = true
    @AppStorage("darkmodeenabled") private var isDarkModeEnabled: Bool = false
    @AppStorage("gamereset") private var isGameReset: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Settings")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.heavy)
                        .background(Color("ColorFormBackground"))
                    Spacer()
                    Button(action: {
                        isPuzzleViewActive = true
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.title)
                            .foregroundColor(.primary)
                    })
                } //: HSTACK
                .padding(.horizontal, 10)
                
                Form {
                    
                    // MARK: - APPLICATION SECTIONS
                    Section(header: Text("Affirmation")) {
                        VStack(alignment: .center, spacing: 15) {
                            Text("A word game where you list as many words as you can from the given affirmation or phrase. Inspired by my beautiful wife, this project allowed me to learn SwiftUI while designing one of her favorite games.")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            Text("Let it inspire you!")
                                .font(.callout)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                                .padding(.bottom, 10)
                        } //: VSTACK
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
                                FormSettingRowView(icon: "moon.circle", firsttext: "Dark Mode")
                                Toggle("Turn dark mode on or off", isOn: $isDarkModeEnabled)
                                    .labelsHidden()
                            } //: HSTACK

                            Button(action: {
                                // Reset the UserDefaults for 'highscore' and 'totalwords'
                                highScore = 0
                                highWords = 0
                                isGameReset.toggle()
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                    .imageScale(.large)
                                Text("Reset All")
                                    .font(.system(.subheadline, design: .rounded))
                                    .fontWeight(.bold)
                            } //: BUTTON
                            .tint(Color("ColorBlue"))
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .controlSize(.regular)
                        }
                        .padding(.vertical, 5)
                    } //: SECTION
                    
                    // MARK: - HIGH SCORE
                    Section(header: Text("Accolades (Single Game)")) {
                        VStack{
                            HStack {
                                FormSettingRowView(icon: "rosette", firsttext: "High Score")
                                Text(String(highScore))
                                    .font(.footnote)
                            } //: HSTACK
                            HStack {
                                FormSettingRowView(icon: "textformat.abc.dottedunderline", firsttext: "Most Words Played")
                                Text(String(highWords))
                                    .font(.footnote)
                            } //: HSTACK
                        }//: VSTACK
                        .padding(.vertical, 5)
                    } //: SECTION
                    
                    // MARK: - ABOUT SECTION
                    Section(header: Text("About the application")) {
                        VStack {
                            FormAboutRowView(icon: "scribble.variable", firstText: k.name[0], secondText: k.name[1], fillColor: Color.blue)
                            FormAboutRowView(icon: "wrench.and.screwdriver", firstText: k.designer[0], secondText: k.designer[1], fillColor: Color.green)
                            FormAboutRowView(icon: "gearshape", firstText: k.compatibility[0], secondText: k.compatibility[1], fillColor: Color.orange)
                            FormAboutRowView(icon: "exclamationmark.shield", firstText: k.version[0], secondText: k.version[1], fillColor: Color.yellow)
                        } //: VSTACK
                        .padding(.vertical, 5)
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
    } //: VIEW
} //: STRUCT

// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
