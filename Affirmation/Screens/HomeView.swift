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
    
    // Create a variable for showing alerts
    @State private var showingAlert: Bool = false
    
    // Set a constant for the date formatter to compare to today's date
    let df = DateFormatter()
    
    // MARK: BODY
    
    var body: some View {
        
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text("affirmation!")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text("It's not how much we give, \n but how much love we put into giving")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: VSTACK
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.1, ImageName: "character-2")
                }
                
                Text(Date(), style: .date)
                    .font(.headline)
                
                Text("The time that leads to mastery is dependent\n on the intesity of our focus.")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    // Set the UserDefault 'gamestartdate' = to today's date
                    df.dateFormat = "dd-MM-yyyy"
                    gameStartDate = df.string(from: Date())
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
            df.dateFormat = "dd-MM-yyyy"
            let todaysDate = df.string(from: Date())
            if gameStartDate != todaysDate {
                showingAlert = true
                UserDefaults.standard.set([String](), forKey: "puzzlewords")
                currentScore = 0
            } //: IF
        } //: ONAPPEAR
        
        // Create the alert
        .alert("A new day means a new puzzle", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } //: ALERT
    
    } //: BODY
} //: STUCT

// MARK: PREVIEW

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
