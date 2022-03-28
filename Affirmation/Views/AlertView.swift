//
//  AlertView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 3/28/22.
//

import SwiftUI

struct AlertView: View {
    // MARK: - PROPERTIES
    @State private var iconName: String = "info.circle.fill"
    @State private var backgroundColor: Color = Color.blue
    let message: String
    let type: String
    
    // MARK: - BODY
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(backgroundColor)
                    .frame(width: 300, height: 150, alignment: .center)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(backgroundColor)
                    .frame(width: 290, height: 140, alignment: .center)
                
                Text(message)
                    .padding(.horizontal, 50)
                    .frame(width: 280, height: 130, alignment: .center)
                    .background(backgroundColor)
                    .cornerRadius(20)
                    .font(.system(size: 18, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
                Image(systemName: iconName)
                    .font(.system(size: 60, design: .rounded))
                    .foregroundColor(Color.white)
                    .background(
                        Circle()
                            .fill(backgroundColor)
                            .frame(width: 80, height: 80, alignment: .center)
                    )
                    .background(
                        Circle()
                            .fill(.white)
                            .frame(width: 88, height: 88, alignment: .center)
                    )
                    .offset(x: -150)
            } //: ZSTACK
            .onAppear {
                switch type {
                case "info":
                    iconName = "info.circle.fill"
                    backgroundColor = Color.blue
                case "error":
                    iconName = "exclamationmark.circle.fill"
                    backgroundColor = Color.red
                default:
                    iconName = "info.circle.fill"
                    backgroundColor = Color.yellow
                }
            }
        } //: VSTACK
    } //: BODY
}


// MARK: - PREVIEW
struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(message: "Your Game Has Been Reset", type: "info")
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
