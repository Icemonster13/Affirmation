//
//  PuzzleView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/19/22.
//

import SwiftUI

struct PuzzleView: View {
    // MARK: - PROPERTIES
    @AppStorage("onboard") var isOnboardingViewActive: Bool = false
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = true
    @AppStorage("settings") var isSettingViewActive: Bool = false
    @AppStorage("currentscore") var currentScore = 0
    @AppStorage("highscore") var highScore = 0
    @AppStorage("totalwords") var totalWords = 0
    
    @State private var newWord = ""
    @State private var usedWord = [String]()
    
    @State private var statusMessage = ""
    @State private var statusColor = Color.clear
    
    let rootWord = "choose happiness"
    
    let uDefaults = UserDefaults.standard
    
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
                                Text(statusMessage)
                                    .padding(6)
                                    .background(statusColor)
                                
                                Spacer()
                                Text("Current: \(currentScore)")
                                    .font(.callout)
                                    .fontWeight(.ultraLight)
                            }//: END OF HSTACK
                        } //: END OF VSTACK
                    } //: END OF SECTION
                    
                    Section {
                        ScrollView(.vertical) {
                            LazyVGrid(columns: layout, spacing: 8) {
                                // ForEach(data, id: \.self) { word in // Used to show test data
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
                        .frame(minWidth: 0, idealWidth: 300, maxWidth: .infinity, minHeight: 0, idealHeight: 500, maxHeight: 500)
                        .padding(0)
                        .background(Image("Notebook Paper 3")
                                        .offset(y: -12))
                    } //: END OF SECTION
                } //: FORM
                .onAppear {
                    usedWord = uDefaults.object(forKey:"puzzlewords") as? [String] ?? [String]()
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
    }
    
    // MARK: - METHODS
    
    func addNewWord() {
        // Lower case the word and remove white space from the ends
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        // Ensure there is more that 0 letters being added
        guard answer.count > 0 else {
            playSound(sound: "Wrong", type: "mp3")
            return
        }
        
        guard isOriginal(word: answer) else {
            statusColor = Color.yellow
            statusMessage = k.isOriginal.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3")
            return
        }
        
        guard isPossible(word: answer) else {
            statusColor = Color.orange
            statusMessage = k.isPossible.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3")
            return
        }
        
        guard isReal(word: answer) else {
            statusColor = Color.red
            statusMessage = k.isReal.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3")
            return
        }
        
        guard hasSpaces(word: answer) else {
            statusColor = Color.red
            statusMessage = k.isReal.randomElement() ?? ""
            newWord = ""
            playSound(sound: "Wrong", type: "mp3")
            return
        }
        
        // Insert the word into the usedWord Array
        withAnimation {
            usedWord.insert(answer, at: 0)
        }
        uDefaults.set(usedWord, forKey: "puzzlewords")
        currentScore += answer.count
        if currentScore > highScore {
            highScore = currentScore
        }
        totalWords += 1
        playSound(sound: "Correct", type: "mp3")
        
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
}

// MARK: - PREVIEW
struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}
