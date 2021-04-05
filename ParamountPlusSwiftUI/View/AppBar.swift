//
//  AppBar.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/24/21.
//

import SwiftUI
import Introspect

struct AppBar: View {
    @Binding var activeIndex: Int
    @State var isFirstIndex = true
    
    var sections = ["Episode", "Related Shows", "About", "Info", "Pizza", "Hamburger", "Pasta", "I dont even know"]
    
    let tabsSpacing = CGFloat(16)

    private func tabWidth(at index: Int) -> CGFloat {
        let label = UILabel()
        label.text = sections[index]
        
        ///I added an extra 2 padding because selected section seems to be lagging and doesnt end on end of text
        ///Seems to be related to tabsSpacing. When 8, padding = 1, when 16, padding = 2.
        let labelWidth = label.intrinsicContentSize.width + 1
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
          if i < activeIndex {
            print("Initial padding: ", padding)
            padding += tabWidth(at: i) + tabsSpacing + 1
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
            
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false, content: {
                   
                        ///Using GeometryReader
                        ///Gets you the x point of frame
    ///                      let x = proxy.frame(in: .global).minX
                        
                        ///Custom nav sections
                        VStack(alignment: .leading) {
                            //Underline bar
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .frame(width: totalTabWidth(data: sections), height: 3)
                                    .foregroundColor(Color.gray)
                                
                                Rectangle()
                                    .frame(width: tabWidth(at: activeIndex), height: 3, alignment: .topLeading)
                                    .foregroundColor(.white)
                                    
                                    ///This padding is what moves the bar
                                    ///Edges, length
                                    .padding(.leading, leadingPadding)
                                    .animation(Animation.spring())
                            }
                            
                            ///Sections
                            HStack(spacing: tabsSpacing) {
                                ForEach(0..<sections.count) { i in
                                    Button(action: {
                                        self.activeIndex = i
                                        
                                        withAnimation(.linear) {
                                            ///This checks ensures that when we select last 2 items, scrollView doesnt try to align selectedIndex to middle
                                            if activeIndex == 0 {
                                                isFirstIndex = true
                                            } else {
                                                isFirstIndex = false
                                            }
                                            
                                            if activeIndex < sections.count - 2 {
                                                proxy.scrollTo(activeIndex, anchor: .center)
                                            } else if activeIndex == sections.count - 2 {
                                                proxy.scrollTo(activeIndex)
                                            } else {
                                                proxy.scrollTo(activeIndex, anchor: .trailing)
                                            }
                                        }
                                    }, label: {
                                        
                                        Text(sections[i])
                                            .foregroundColor(self.activeIndex == i ? .white : Color.white.opacity(0.7))
                                            .fontWeight(.bold)
                                            .font(.system(size: 16))
                                            .background(Color(UIColor(named: "DarkMatter") ?? .red))
                                            .onChange(of: activeIndex, perform: { value in
                                                
                                                withAnimation(.linear) {
                                                    
                                                    if activeIndex == 0 {
                                                        isFirstIndex = true
                                                    } else {
                                                        isFirstIndex = false
                                                    }
                                                    
                                                    ///This checks ensures that when we select last 2 items, scrollView doesnt try to align selectedIndex to middle
                                                    if activeIndex < sections.count - 2 {
                                                        proxy.scrollTo(activeIndex, anchor: .center)
                                                    } else if activeIndex == sections.count - 2 {
                                                        proxy.scrollTo(activeIndex)
                                                    } else {
                                                        proxy.scrollTo(activeIndex, anchor: .trailing)
                                                    }
                                                }
                                                
                                            })
                                    })
                                    .id(i)
                                   
                                }
                            }
                            
                           Spacer()
                            .frame(height: 10)
                            
                        }
                })
            }
            
            .introspectScrollView { (scrollView) in
                scrollView.bounces = false
            }
        }
        
        .background(isFirstIndex ? Color.gray.opacity(0.7) : Color(UIColor(named: "DarkMatter") ?? .red))
    }
}


struct AppBar_Previews: PreviewProvider {
    @State static var value = 0
    
    static var previews: some View {
        AppBar(activeIndex: $value)
    }
}



