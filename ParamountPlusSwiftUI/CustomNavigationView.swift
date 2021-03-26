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
    @State var index = 0
    var body: some View {
        
        VStack(spacing: 0) {
            
            
            AppBar(index: self.$index)

            TabView(selection: self.$index,
                    content:  {
                        First()
                            .tag(0)
                        RecommendationPage()
                            .tag(1)
                        NewView(text: "Third", color: Color.orange)
                            .tag(2)
                        NewView(text: "Fourth", color: Color.green)
                            .tag(3)
                        NewView(text: "Fifth", color: Color.red)
                            .tag(4)
                        NewView(text: "Sixth", color: Color.blue)
                            .tag(5)
                        NewView(text: "Seventh", color: Color.purple)
                            .tag(6)
                        NewView(text: "Eighth", color: Color.pink)
                            .tag(7)
                        
                    })

                ///Allows the swipe to happen
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(index: 0)
    }
}

struct First: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(1...5, id: \.self) { item in
                    Text("item: \(item)")
                }
            }
        }
        .padding(.bottom, 18)
    }
}


struct NewView: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .background(color)
    }
}
