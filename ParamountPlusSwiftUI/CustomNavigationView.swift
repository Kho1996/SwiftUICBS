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
                        Third()
                            .tag(2)
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

struct Second: View {
    var body: some View {
        Text("Second View")
            .background(Color.green)
    }
}

struct Third: View {
    var body: some View {
        Text("Third View")
            .background(Color.yellow)
    }
}
