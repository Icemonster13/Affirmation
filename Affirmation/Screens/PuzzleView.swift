//
//  PuzzleView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/19/22.
//

import SwiftUI

struct PuzzleView: View {
    
    // MARK: - PROPERTIES
    
    // Access the UserDefaults
    @AppStorage("onboard") var isOnboardingViewActive: Bool = false
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = true
    @AppStorage("settings") var isSettingViewActive: Bool = false
    
    @AppStorage("currentscore") var currentScore = 0
    @AppStorage("highscore") var highScore = 0
    @AppStorage("totalwords") var totalWords = 0
    @AppStorage("soundenabled") private var isSoundEnabled: Bool = true
    
    // Create variables to store the new word and the list of used words
    @State private var newWord = ""
    @State private var usedWord = [String]()
    
    // Create variables to store the status message and color
    @State private var statusMessage = ""
    @State private var statusColor = Color.clear
    
    // Constant to hold the Affirmation Phrase
    let rootWord = "choose happiness"
    
    // Constant for the grid layout structure
    let layout = [
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading),
        GridItem(.flexible(), alignment: .leading)
    ]
    
    // MARK: - BODY
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                Text(rootWord)
                
                Form {
                    Section {
                        VStack {
                            HStack {
                                TextField("Enter your word:", text: $newWord)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .onSubmit {
                                        addNewWord()
                                    }
                                Text("Best: \(highScore)")
                                    .font(.callout)
                                    .fontWeight(.ultraLight)
                            } //: END OF HSTACK
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(statusColor)
                                    Text(statusMessage)
                                        .padding(3)
                                        .foregroundColor(.white)
                                }//: END OF ZSTACK
                                .padding(.trailing, 15)
                                Spacer()
                                Text("Current: \(currentScore)")
                                    .font(.callout)
                                    .fontWeight(.ultraLight)
                            }//: END OF HSTACK
                            HStack() {
                                Spacer()
                                Button(action: {
                                    // Reset the UserDefaults for 'currentscore' and 'puzzlewords'
                                    // Reset the status color and message
                                    currentScore = 0
                                    usedWord.removeAll()
                                    UserDefaults.standard.set(usedWord, forKey: "puzzlewords")
                                    statusColor = Color.clear
                                    statusMessage = ""
                                }) {
                                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                                        .imageScale(.large)
                                    Text("Reset Game")
                                        .font(.system(.subheadline, design: .rounded))
                                        .fontWeight(.bold)
                                } //: BUTTON
                                .tint(Color.blue)
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.capsule)
                                .controlSize(.regular)
                                Spacer()
                            } //: HSTACK
                            .padding(5)
                        } //: END OF VSTACK
                    } //: END OF SECTION
                    
                    Section {
                        ScrollView(.vertical) {
                            LazyVGrid(columns: layout, spacing: 8) {
                                ForEach(usedWord, id: \.self) { word in
                                    HStack() {
                                        Image(systemName: "\(word.count).square.fill")
                                            .foregroundColor(word.count > 5 ? Color.green : Color.yellow)
                                        Text(word)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.secondary)
                                            .font(.custom("ShadowsIntoLightTwo-Regular", size: 18))
                                    } //: END OF HSTACK
                                } //: END OF FOREACH
                            } //: END OF LAZYVGRID
                        } //: END OF SCROLLVIEW
                        .frame(minWidth: 0, idealWidth: 300, maxWidth: 500, minHeight: 0, idealHeight: 500, maxHeight: 500, alignment: .center)
                        .padding(0)
                        .background(Image("Notebook Paper 3")
                                        .offset(y: -12))
                    } //: END OF SECTION
                } //: FORM
                .onAppear {
                    usedWord = UserDefaults.standard.object(forKey:"puzzlewords") as? [String] ?? [String]()
                }
            } //: VSTACK
            .overlay(
                Button(action: {
                    isPuzzleViewActive = false
                    isSettingViewActive = true
                }, label: {
                    Image(systemName: "info.circle")
                        .font(.title)
                        .padding(.trailing, 10)
                        .foregroundColor(Color.secondary)
                })
                , alignment: .topTrailing
            )
            .overlay(
                Button(action: {
                    isPuzzleViewActive = false
                    isSettingViewActive = false
                }, label: {
                    Image(systemName: "chevron.backward.circle")
                        .font(.title)
                        .padding(.leading, 10)
                        .foregroundColor(Color.secondary)
                })
                , alignment: .topLeading
            )
        } //: ZSTACK
    } //: VIEW
    
    // MARK: - METHODS
    
    func addNewWord() {
        // Lower case the word and remove white space from the ends
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // Ensure there is more that 0 letters being added
        guard answer.count > 0 else {
            playSound(sound: "Wrong", type: "mp3", enabled: isSoundEnabled)
            return
        }
        
        guard isOriginal(word: answer) else {
            statusColor = Color.yellow
            statusMessage = k.isOriginal.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3", enabled: isSoundEnabled)
            return
        }
        
        guard isPossible(word: answer) else {
            statusColor = Color.orange
            statusMessage = k.isPossible.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3", enabled: isSoundEnabled)
            return
        }
        
        guard isReal(word: answer) else {
            statusColor = Color.red
            statusMessage = k.isReal.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3", enabled: isSoundEnabled)
            return
        }
        
        guard hasSpaces(word: answer) else {
            statusColor = Color.red
            statusMessage = k.isReal.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3", enabled: isSoundEnabled)
            return
        }
        
        // Insert the word into the usedWord Array
        withAnimation {
            usedWord.insert(answer, at: 0)
        }
        UserDefaults.standard.set(usedWord, forKey: "puzzlewords")
        currentScore += answer.count
        if currentScore > highScore {
            highScore = currentScore
        }
        totalWords += 1
        playSound(sound: "Correct", type: "mp3", enabled: isSoundEnabled)
        
        // Reset the newWord to blank
        statusColor = Color.green
        statusMessage = k.isAccepted.randomElement() ?? ""
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWord.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func hasSpaces(word: String) -> Bool {
        !word.contains(" ")
    }
} //: STRUCT

// MARK: - PREVIEW

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
