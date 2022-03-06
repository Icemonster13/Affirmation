//
//  FormSettingRowView.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 3/6/22.
//

import SwiftUI

struct FormSettingRowView: View {
    var icon: String
    var firsttext: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
                    .font(.footnote)
            } //: ZSTACK
            .frame(width: 28, height: 28, alignment: .center)
            Text(firsttext)
                .foregroundColor(Color.gray)
                .font(.footnote)
            Spacer()
        }
    }
}

struct FormSettingRowView_Previews: PreviewProvider {
    static var previews: some View {
        FormSettingRowView(icon: "speaker.wave.3", firsttext: "Sound Effects")
            .previewLayout(.fixed(width: 375, height: 60))
            .padding()
    }
}
