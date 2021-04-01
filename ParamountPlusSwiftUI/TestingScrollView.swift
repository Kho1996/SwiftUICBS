//
//  TestingScrollView.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/31/21.
//

import SwiftUI

struct TestingScrollView: View {
    @State var selectedIndex = 0
    
    var body: some View {
        
        VStack {
            
            
            
            NavigationView {
                
                    VStack {
                        ///NavBar
                        ScrollView(.horizontal) {
                            ScrollViewReader {proxy in
                                VStack {
                                    HStack(spacing: 10) {
                                        ForEach(0..<8) { i in
                                            Button(action: {
                                                self.selectedIndex = i
                                                
                                                proxy.scrollTo(selectedIndex, anchor: .center)
                                                
                                            }, label: {
                                                Text(i.description)
                                                    .frame(width: 100, alignment: .center)
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 16))
                                                    .background(Color(UIColor(named: "DarkMatter") ?? .red))
                                                
                                                    .onChange(of: selectedIndex, perform: { value in
                                                        proxy.scrollTo(value, anchor: .center)
                                                    })
                                                    
                                            })
                                            
                                            .id(i)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        TabView(selection: self.$selectedIndex,
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
                        
                        
                        .frame(maxWidth: .infinity)
                    }
                
            }
//            .frame(width: screenWidth)
            .navigationBarColor(backgroundColor: UIColor.red, titleColor: UIColor.blue)
            .navigationTitle("Kenny")
            
            
        }
    }
}


struct NavigationBarModifier: ViewModifier {
    var backgroundColor: UIColor?
    var titleColor: UIColor?
    
    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}

struct TestingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TestingScrollView()
    }
}


struct NewAppBar: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        Text("Kenny")
    }
}
