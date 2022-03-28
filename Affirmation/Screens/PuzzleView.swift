//
//  PuzzleView2.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 3/7/22.
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
    @AppStorage("highwords") var highWords = 0
    
    @AppStorage("soundenabled") private var isSoundEnabled: Bool = true
    @AppStorage("gamereset") private var isGameReset: Bool = false
    
    // Create variables to store the new word and the list of used words
    @State private var newWord = ""
    @State private var usedWord = [String]()
    
    // Create variables to store the status message and color
    @State private var statusMessage = ""
    @State private var statusColor = Color.clear
    
    // Constant for the grid layout structure
    let layout = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var affirmation: Affirmation
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            
            VStack(alignment: .center, spacing: 5) {
                
                // MARK: - HEADER
                HStack {
                    Button(action: {
                        isPuzzleViewActive = false
                        isSettingViewActive = false
                    }, label: {
                        Image(systemName: "chevron.backward.circle")
                            .font(.title)
                            .foregroundColor(Color.primary)
                    })
                    Spacer()
                    Text("affirmation!")
                        .font(.system(size: 40, design: .rounded))
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.primary)
                    Spacer()
                    Button(action: {
                        isPuzzleViewActive = false
                        isSettingViewActive = true
                    }, label: {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(Color.primary)
                    })
                } //: END OF HSTACK
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                
                // MARK: - SCORES AND BUTTON
                HStack {
                    Text("Best: \(highScore)")
                        .foregroundColor(Color.primary)
                    Spacer()
                    Button(action: {
                        // Reset the UserDefaults for 'currentscore' and 'puzzlewords'
                        // Reset the status color and message
                        currentScore = 0
                        usedWord.removeAll()
                        UserDefaults.standard.set(usedWord, forKey: "puzzlewords")
                        totalWords = usedWord.count
                        statusColor = Color.clear
                        statusMessage = ""
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .imageScale(.large)
                        Text("Reset Game")
                            .font(.system(.footnote, design: .rounded))
                            .fontWeight(.bold)
                    } //: BUTTON
                    .tint(Color("ColorBlue"))
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.regular)
                    Spacer()
                    Text("Current: \(currentScore)")
                        .foregroundColor(Color.primary)
                } //: END OF HSTACK
                .padding(.horizontal, 15)
                .padding(.bottom, 15)
                    
                // MARK: - PHRASE, WORD ENTRY, AND STATUS
                Capsule()
                    .frame(height: 1, alignment: .center)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 15)
                Text("Create as many words as you can using")
                    .font(.title2)
                    .foregroundColor(Color.primary)
                Text("'\(affirmation.phrase)'")
                    .font(.title)
                    .foregroundColor(Color.green)
                    .fontWeight(.bold)
                TextField("Enter your word:", text: $newWord)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onSubmit {
                        addNewWord()
                    }
                    .padding()
                    .border(Color.primary, width: 1)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(statusColor)
                        .frame(height: 30, alignment: .leading)
                    Text(statusMessage)
                        .foregroundColor(.white)
                } //: END OF ZSTACK
                .padding(.horizontal, 15)

                // MARK: - ANSWER SCROLLVIEW
                Capsule(style: .continuous)
                    .frame(height: 1, alignment: .center)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 15)

                Text("Correct Answers ( \(totalWords) )")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: layout, spacing: 1) {
                        
                        ForEach(usedWord, id: \.self) { word in
                            VStack(alignment: .center, spacing: 4) {
                                HStack() {
                                    Image(systemName: "\(word.count).square.fill")
                                        .foregroundColor(word.count > 5 ? Color.green : Color.yellow)
                                    Text(word)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.secondary)
                                        .font(.custom("ShadowsIntoLightTwo-Regular", size: 18))
                                }
                                Capsule(style: .continuous)
                                    .frame(height: 1, alignment: .center)
                            } //: END OF VSTACK
                        } //: END OF FOREACH
                    } //: END OF LAZYVGRID
                } //: END OF SCROLLVIEW
                .padding()

            } //: END OF VSTACK
        } //: END OF ZSTACK
        .background(Color("ColorFormBackground"))
        .onAppear {
            if isGameReset {
                currentScore = 0
                usedWord.removeAll()
                UserDefaults.standard.set(usedWord, forKey: "puzzlewords")
                totalWords = usedWord.count
                statusColor = Color.clear
                statusMessage = ""
                isGameReset.toggle()
            }
            usedWord = UserDefaults.standard.object(forKey:"puzzlewords") as? [String] ?? [String]()
        }
    }
    
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
        if totalWords > highWords {
            highWords = totalWords
        }
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
        var tempWord = affirmation.phrase
        
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
struct PuzzleView2_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PuzzleView(affirmation: affirmationData[1])
        }
    }
}
