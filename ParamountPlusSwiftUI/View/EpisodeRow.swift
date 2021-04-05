//
//  EpisodeRow.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 4/5/21.
//

import SwiftUI

struct EpisodeRow: View {
    var description: String
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 120, height: 120)
                .foregroundColor(Color.red)
            Spacer()
                .frame(width: 20)
            Text(description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.green)
        }
        .frame(width: screenWidth, height: 120)
        .padding(.leading)
        
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        let description = ""
        EpisodeRow(description: description)
    }
}
