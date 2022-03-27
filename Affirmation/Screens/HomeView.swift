//
//  HomeView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/14/22.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: PROPERTIES
    
    // Access the UserDefaults
    @AppStorage("home") var isHomeViewActive: Bool = true
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = false
    @AppStorage("gamestartdate") var gameStartDate: String = "01-01-1901"
    @AppStorage("currentscore") var currentScore = 0
    @AppStorage("phraseid") var phraseID: Int = 1
    
    // Create a variable for showing alerts
    @State private var showingAlert: Bool = false
    
    var affirmation: Affirmation
    
    // MARK: BODY
    
    var body: some View {
        
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 10) {
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("affirmation!")
                        .font(.system(size: 60, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text(Date(), style: .date)
                        .font(.headline)
                        .foregroundColor(.white)
                } //: VSTACK
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.1, ImageName: "character-2")
                }
                
                Text(affirmation.affirmation)
                    .font(.title)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // Set the UserDefault 'gamestartdate' equal to today's date
                    k.df.dateFormat = "dd-MM-yyyy"
                    gameStartDate = k.df.string(from: Date())
                    isPuzzleViewActive.toggle()
                }) {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Play Today's Puzzle")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                } //: BUTTON
                .tint(Color.secondary)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.regular)
                
                Spacer()
                
            } //: VSTACK
        } //: ZSTACK
        
        .onAppear {
            // Compare today's date to the UserDefault 'gamestartdate'
            // If the dates are different, reset the UserDefault 'puzzlewords'
            // and the UserDefault 'currentscore'
            k.df.dateFormat = "dd-MM-yyyy"
            let todaysDate = k.df.string(from: Date())
            if gameStartDate != todaysDate {
                showingAlert = true
                UserDefaults.standard.set([String](), forKey: "puzzlewords")
                currentScore = 0
                // Choose the next phrase in the array. If it has hit the end, start over.
                if (phraseID + 1) > (k.affirmationCount - 1) {
                    phraseID = 0
                } else {
                    phraseID += 1
                }
            } //: IF
        } //: ONAPPEAR
        
        // Create the alert
        .alert("A new day means a new puzzle.", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } //: ALERT
    
    } //: BODY
} //: STUCT

// MARK: PREVIEW

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(affirmation: affirmationData[1])
    }
}
