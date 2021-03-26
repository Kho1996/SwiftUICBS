//
//  AppBar.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/24/21.
//

import SwiftUI

struct AppBar: View {
    @Binding var index: Int
    
    var sections = ["Episode", "Related Shows", "About", "Info", "Pizza", "Hamburger", "Pasta", "I dont even know"]
    
    let tabsSpacing = CGFloat(8)

    private func tabWidth(at index: Int) -> CGFloat {
        let label = UILabel()
        label.text = sections[index]
        let labelWidth = label.intrinsicContentSize.width
        return labelWidth
      }

      private var leadingPadding: CGFloat {
        
        
//        let label = UILabel()
//        label.text = sections[index]
//        let labelWidth = label.intrinsicContentSize.width
        
        ///Padding should be the difference between text and left and right padding
        var padding: CGFloat = 0
        for i in 0..<sections.count {
          if i < index {
            padding += tabWidth(at: i) + tabsSpacing
          }
        }
        return padding
      }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ///Custom Nav Ttitle
            Text("Home")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                .frame(width: UIScreen.main.bounds.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.white)
                .padding(.bottom, 8)
                .background(Color.yellow)
            
            ScrollView(.horizontal, content: {
                ScrollViewReader { proxy in
                    ///Custom nav sections
                    VStack(alignment: .leading) {
                        HStack(spacing: tabsSpacing) {
                                ForEach(0..<sections.count) { i in
                                    Button(action: {
                                        self.index = i
                                        withAnimation(.linear) {
                                            proxy.scrollTo(i, anchor: .center)
                                        }
                                       
                                    }, label: {
                                        VStack(spacing: 8) {
                                            
                                            Text(sections[i])
                                                .foregroundColor(self.index == i ? .white : Color.white.opacity(0.7))
                                                .fontWeight(.bold)
                                                .font(.system(size: 16))
                                                .background(Color.blue)
//                                    ZStack {
//
//                                        Capsule()
//                                            .foregroundColor(.gray)
//                                            .frame(height: 4)
//
//                                        Capsule()
//                                            .foregroundColor(self.index == i ? .white : Color.clear)
//                                            .frame(height: 4)
//                                    }
                                        }

                                    })
                                    .background(Color.red)
                                    .id(i)
                                }
                        }
                        //Underline bar
                        Rectangle()
                            .frame(width: tabWidth(at: index) + 8, height: 3, alignment: .bottomLeading)
                            .foregroundColor(.blue)
                            
                            ///This padding is what moves the bar
                            .padding(.leading, leadingPadding)
                            .animation(Animation.spring())
                    }
                        
                    
                }
            })
        }
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + 15)
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color(UIColor(named: "DarkMatter") ?? .red))
    }
}


struct AppBar_Previews: PreviewProvider {
    @State static var value = 0
    
    static var previews: some View {
        AppBar(index: $value)
    }
}


struct CustomButton: View {
    @Binding var index: Int
    var buttonText: String
    var indexSelected: Int?
    
    var body: some View {
        Button(action: {
            self.index = 0
            
        }, label: {
            VStack(spacing: 8) {
                Text(buttonText)
                    .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.7))
                    
                    .fontWeight(self.index == 0 ? .bold : .regular)
                    .font(.system(size: 16))
                
                ZStack {
                    Capsule()
                        .foregroundColor(.gray)
                        .frame(height: 4)
                    Capsule()
                        .foregroundColor(self.index == 0 ? .white : Color.clear)
                        .frame(height: 4)
                }
            }
        })
        .frame(width: 120, alignment: .center)
    }
}

