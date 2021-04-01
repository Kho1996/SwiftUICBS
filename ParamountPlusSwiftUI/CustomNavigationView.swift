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
    @State var activeIndex = 0
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 0) {
                AppBar(activeIndex: self.$activeIndex)

                TabView(selection: self.$activeIndex,
                        content:  {
                            First()
                                .tag(0)
                            RecommendationPage()
                                .tag(1)
                            
                            NewView(text: "Third", color: Color.orange, index: 2)
                            NewView(text: "Fourth", color: Color.green, index: 3)
                            NewView(text: "Fifth", color: Color.red, index: 4)
                            NewView(text: "Sixth", color: Color.blue, index: 5)
                            NewView(text: "Seventh", color: Color.purple, index: 6)
                            NewView(text: "Eighth", color: Color.pink, index: 7)
                              
                        })

                    ///Allows the swipe to happen
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
            }
            
            
        }.navigationTitle("Home")
        
        

    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(activeIndex: 0)
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
    var index: Int
    
    var body: some View {
        Text(text)
            .background(color)
            .tag(index)
    }
}
