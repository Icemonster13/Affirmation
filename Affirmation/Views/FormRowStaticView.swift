//
//  FormRowStaticView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 2/26/22.
//

import SwiftUI

struct FormRowStaticView: View {

    // MARK: - PROPERTIES
    var icon: String
    var firstText: String
    var secondText: String
    var fillColor: Color

    // MARK: - BODY
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(fillColor)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
                    .font(.footnote)
            }
            .frame(width: 24, height: 24, alignment: .center)
            Text(firstText)
                .foregroundColor(Color.gray)
                .font(.footnote)
            Spacer()
            Text(secondText)
                .font(.footnote)
        }
    }
}

// MARK: - PREVIEW
struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "scribble.variable", firstText: "Application", secondText: "Affirmation", fillColor: Color.gray)
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
