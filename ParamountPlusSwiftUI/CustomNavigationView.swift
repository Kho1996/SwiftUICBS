//
//  CustomNavigationView.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/19/21.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

struct CustomNavigationView: View {
    
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Spongebob SquarePants")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 20))
                
              
                
                HStack(spacing: 24) {
                    Text("Episode")
                    Text("Related Shows")
                    Text("About")
                }
                .frame(height: 40)
                
                Spacer()
            }
            .frame(width: screenWidth)
            .padding()
            
            
        }
        
        
        
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView()
    }
}
