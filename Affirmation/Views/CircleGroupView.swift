//
//  CircleGroupView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/14/22.
//

import SwiftUI

struct CircleGroupView: View {
    // MARK: - PROPERTY
    @State var ShapeColor: Color
    @State var ShapeOpacity: Double
    @State var ImageName: String
    
    // MARK: - BODY
    var body: some View {
        // Creates a reusable asset with two circles and one image
        ZStack {
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 40)
                .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(ShapeColor.opacity(ShapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
            Image(ImageName)
                .resizable()
                .scaledToFit()
                .padding()
                .frame(minWidth: 260, idealWidth: 300, maxWidth: 500, minHeight: 260, idealHeight: 300, maxHeight: 500, alignment: .center)
        } //: ZSTACK
    }
}

// MARK: - PREVIEW
struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            CircleGroupView(ShapeColor: .green, ShapeOpacity: 0.5, ImageName: "character-2")
            
        }
    }
}
