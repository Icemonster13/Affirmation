//
//  HomeView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/14/22.
//

import SwiftUI

struct HomeView: View {
    // MARK: PROPERTY
    @AppStorage("onboard") var isOnboardingViewActive: Bool = false
    @AppStorage("puzzle") var isPuzzleViewActive: Bool = false
    @AppStorage("settings") var isSettingViewActive: Bool = false
    @AppStorage("gamestartdate") var gameStartDate: String = ""
    
    // MARK: BODY
    var body: some View {
        
        VStack(spacing: 20) {
            // MARK: - HEADER
            
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1, ImageName: "character-2")
            }
            
            // MARK: - CENTER
            
            Text(Date(), style: .date)
                .font(.headline)
            Text("The time that leads to mastery is dependent on the intesity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            // MARK: - FOOTER
            
            Spacer()
            
            Button(action: {
                
                isPuzzleViewActive.toggle()
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Play Today's Puzzle")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            } //: BUTTON
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.regular)
            
            Spacer()
            
        } //: VSTACK
        .overlay(
            Button(action: {
                isOnboardingViewActive.toggle()
            }, label: {
                Image(systemName: "chevron.backward.circle")
                    .font(.title)
                    .padding(.leading, 10)
                    .foregroundColor(Color.secondary)
            })
            , alignment: .topLeading
        )
    }
}

// MARK: PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
