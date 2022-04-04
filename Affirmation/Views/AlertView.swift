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
    let title: String
    let message: String
    let type: String
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - BACKGROUND BLUR
            
            
            // MARK: - OUTER BORDER - WITH COLOR
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .frame(width: 300, height: 200, alignment: .center)
            
            // MARK: - INNER BORDER - WHITE
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 290, height: 190, alignment: .center)
            
            // MARK: - INSIDE FRAME - WITH COLOR
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .frame(width: 275, height: 180, alignment: .center)
            
            // MARK: - INNER CONTENT - TITLE, MESSAGE, AND BUTTON
            VStack {
                Text(title)
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .padding(5)
                    .textCase(.uppercase)
                
                Text(message)
                    .background(backgroundColor)
                    .font(.system(size: 14, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                
                Button(action: {
                    // Dismiss the alert view
                }, label: {
                    Text("OK")
                        .padding(.horizontal, 40)
                        .font(.system(size: 14, weight: .heavy, design: .rounded))
                })
                .tint(Color.secondary)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.regular)
                .padding(5)
            } //: VSTACK
            .frame(width: 270, height: 170, alignment: .center)
            .offset(x: 10)

            // MARK: - NOTIFICATION ICON - WITH COLOR
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
    } //: BODY
}


// MARK: - PREVIEW
struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(title: "Error", message: "You have done something that created an error.", type: "error")
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
