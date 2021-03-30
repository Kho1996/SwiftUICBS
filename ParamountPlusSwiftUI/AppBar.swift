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
    
    let tabsSpacing = CGFloat(16)

    private func tabWidth(at index: Int) -> CGFloat {
        let label = UILabel()
        label.text = sections[index]
        
        ///I added an extra 2 padding because selected section seems to be lagging and doesnt end on end of text
        ///Seems to be related to tabsSpacing. When 8, padding = 1, when 16, padding = 2.
        let labelWidth = label.intrinsicContentSize.width + 2
        print("LabelWidth:",labelWidth)
        return labelWidth
      }
    
    private func totalTabWidth(data: [String]) -> CGFloat {
        var totalWidth: CGFloat = 0
        for i in data {
            let label = UILabel()
            label.text = i
            let labelWidth = label.intrinsicContentSize.width
            totalWidth += labelWidth + tabsSpacing
        }
        
        return totalWidth
    }

      private var leadingPadding: CGFloat {
        ///Padding should be the difference between text and left and right padding
        var padding: CGFloat = 0
        for i in 0..<sections.count {
          if i < index {
            print("Initial padding: ", padding)
            padding += tabWidth(at: i) + tabsSpacing
            print("Final padding: \(padding) after adding indexTabWidth: \(tabWidth(at: i)) and \(tabsSpacing)")
          }
        }
        
        print("Final Padding \(padding)")
        return padding
      }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ///Custom Nav Ttitle
            Text("Home")
                .font(.system(size: 22, weight: .semibold))
                .frame(width: UIScreen.main.bounds.width)
                .foregroundColor(.white)
                .padding(.bottom, 8)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                ScrollViewReader { proxy in
                    ///Custom nav sections
                    VStack(alignment: .leading) {
                        //Underline bar
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: totalTabWidth(data: sections), height: 3)
                                .foregroundColor(Color.gray)
                            
                            Rectangle()
                                .frame(width: tabWidth(at: index), height: 3, alignment: .topLeading)
                                .foregroundColor(.white)
                                
                                
                                ///This padding is what moves the bar
                                ///Edges, length
                                .padding(.leading, leadingPadding)
                                .animation(Animation.spring())
                        }
                        
                        .frame(height: 10)
                        
                        ///Sections
                        HStack(spacing: tabsSpacing) {
                                ForEach(0..<sections.count) { i in
                                    Button(action: {
                                        self.index = i
                                        
                                        withAnimation(.linear) {
                                            
                                            ///This checks ensures that when we select last 2 items, scrollView doesnt try to align selectedIndex to middle
                                            if i < sections.count - 2 {
                                                proxy.scrollTo(i, anchor: .center)
                                            } else if i == sections.count - 2 {
                                                proxy.scrollTo(i)
                                        } else {
                                                proxy.scrollTo(i, anchor: .trailing)
                                            }
                                        }
                                        
                                    }, label: {
                                        Text(sections[i])
                                            .foregroundColor(self.index == i ? .white : Color.white.opacity(0.7))
                                            .fontWeight(.bold)
                                            .font(.system(size: 16))
                                            .background(Color.blue)
                                    })
                                    .id(i)
                                }
                        }
                        
                        .background(Color.green)
                        .padding(.leading, 6)
                        
                       Spacer()
                        .frame(height: 10)
                        
                    }
                }
                .modifier(ScrollViewModifier())
            })
            
            
            
            
        }
        .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0) + 15)
//        .padding(.horizontal)
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


struct ScrollViewModifier: ViewModifier {
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    func body(content: Content) -> some View {
        return content
    }
}

