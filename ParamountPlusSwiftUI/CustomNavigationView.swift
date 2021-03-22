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
        ShowPage()
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView()
    }
}

struct ShowPage : View {
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

struct AppBar: View {
    @Binding var index: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ///Custom Nav Ttitle
            Text("Home")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding(.leading)
                .padding(.bottom)
            
            
            ///Custom nav sections
            HStack(spacing: 0) {
                
                ///Episode Page
                Button(action: {
                    self.index = 0
                    
                }) {
                    VStack(spacing: 8) {
                        Text("Episode")
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.7))
                            .font(.system(size: 16))
                        
                        Capsule()
                            .foregroundColor(self.index == 0 ? .white : Color.clear)
                            .frame(height: 4)
                    }
                }
  
                ///Related Shows section
                Button(action: {
                    self.index = 1
                    
                    
                }) {
                    VStack(spacing: 8) {
                        
                        Text("Related Shows")
                            .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.7))
                            .font(.system(size: 16))
                        
                        
                        Capsule()
                            .foregroundColor(self.index == 1 ? .white : Color.clear)
                            .frame(height: 4)
                    }
                }
                
                ///About section
                Button(action: {
                    self.index = 2
                }) {
                    VStack(spacing: 8) {
                        Text("About")
                            .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.7))
                            .font(.system(size: 16))
                        
                        Capsule()
                            .foregroundColor(self.index == 2 ? .white : Color.clear)
                            .frame(height: 4)
                    }
                    
                }
            }
            
        }
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 15)
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color.red)
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
