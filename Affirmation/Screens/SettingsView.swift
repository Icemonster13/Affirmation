//
//  SettingsView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/26/22.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTIES
    @AppStorage("onboard") var isOnboardingViewActive: Bool = false
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = true
    @AppStorage("highscore") var highScore = 0
    @AppStorage("totalwords") var totalWords = 0
    
    @State private var isSoundEnabled: Bool = true
    
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
                                .padding(2)
                            Text("Let it inspire you!")
                                .font(.callout)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                        }
                    }
                    
                    // MARK: - SETTING SECTION
                    Section(header: Text("Settings")) {
                        VStack {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color.gray)
                                    Image(systemName: "speaker.wave.3")
                                        .foregroundColor(Color.white)
                                        .font(.footnote)
                                } //: ZSTACK
                                .frame(width: 28, height: 28, alignment: .center)
                                Text("Sound Effects")
                                    .foregroundColor(Color.gray)
                                    .font(.footnote)
                                Spacer()
                                Toggle("Turn sound on or off", isOn: $isSoundEnabled)
                                    .labelsHidden()
                            } //: HSTACK
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color.gray)
                                    Image(systemName: "rosette")
                                        .foregroundColor(Color.white)
                                        .font(.footnote)
                                } //: ZSTACK
                                .frame(width: 28, height: 28, alignment: .center)
                                Text("High Score")
                                    .foregroundColor(Color.gray)
                                    .font(.footnote)
                                Spacer()
                                Text(String(highScore))
                                    .font(.footnote)
                            } //: HSTACK
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color.gray)
                                    Image(systemName: "textformat.abc.dottedunderline")
                                        .foregroundColor(Color.white)
                                        .font(.footnote)
                                } //: ZSTACK
                                .frame(width: 28, height: 28, alignment: .center)
                                Text("Total Words Played")
                                    .foregroundColor(Color.gray)
                                    .font(.footnote)
                                Spacer()
                                Text(String(totalWords))
                                    .font(.footnote)
                            } //: HSTACK
                            Button(action: {
                                highScore = 0
                                totalWords = 0
                            }) {
                                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                    .imageScale(.large)
                                Text("Reset All Statistics")
                                    .font(.system(.subheadline, design: .rounded))
                                    .fontWeight(.bold)
                            } //: BUTTON
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.capsule)
                            .controlSize(.regular)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
                    
                    // MARK: - ABOUT SECTION
                    Section(header: Text("About the application")) {
                        VStack {
                            FormRowStaticView(icon: "scribble.variable", firstText: "Application", secondText: "Affirmation", fillColor: Color.blue)
                            FormRowStaticView(icon: "wrench.and.screwdriver", firstText: "Designer", secondText: "Michael Pascucci", fillColor: Color.green)
                            FormRowStaticView(icon: "gearshape", firstText: "Compatibility", secondText: "iPhone / iPad", fillColor: Color.orange)
                            FormRowStaticView(icon: "exclamationmark.shield", firstText: "Version", secondText: "1.0.0", fillColor: Color.yellow)
                        } //: VSTACK
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                    }
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
    }
}

// MARK: - PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
