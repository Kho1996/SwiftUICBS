//
//  TestingScrollView.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/31/21.
//

import SwiftUI
import Introspect

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
                    .navigationTitle("Kenny")
                    .navigationBarTitleDisplayMode(.inline)
                    .background(Color.yellow)
                    
                
            }

            .introspectNavigationController(customize: { (navigationController) in
                navigationController.navigationBar.isTranslucent = false
                
                let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = .purple
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navigationController.navigationBar.standardAppearance = appearance
            })
        }
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
