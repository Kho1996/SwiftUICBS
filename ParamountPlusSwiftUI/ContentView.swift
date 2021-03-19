//
//  ContentView.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 2/8/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var offset: CGFloat = 0
    
    var colors: [Color] = [.red,.blue,.yellow, .orange]
    
    var body: some View {
        ///Since tabview has a issue with ignoring top edges, we put in within a scrollView
        ScrollView(.init()) {
            TabView {
                ForEach(colors.indices, id: \.self) { index in
                    colors[index]
                    
                    if index == 0 {
                        colors[index]
                            .overlay(
                            ///Geometry reader for getting offset...
                                GeometryReader { proxy -> Color in
                                    
                                    let minX = proxy.frame(in: .global).minX
                                    
                                    DispatchQueue.main.async {
                                        self.offset = -minX
                                    }
                                    
                                    return Color.clear
                                }
                                
                                .frame(width: 0, height: 0)
                                , alignment: .leading
                            )
                    } else {
                        colors[index]
                    }
                    
                }
            }
            
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            .overlay(
                
                HStack(spacing: 15) {
                    ForEach(colors.indices, id: \.self) { index in
                        Capsule()
                            .fill(Color.white)
                            .frame(width: getIndex() == index ? 20 : 7, height: 7)
                    }
                }
                ///Smooth Sliding Effect...
                .overlay(
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 20, height: 7)
                        .offset(x: getOffSet())
                    ,alignment: .leading
                    )
                
                
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .padding(.bottom, 10)
                ,alignment: .bottom
            )
        }
        .ignoresSafeArea()
    }
    
    ///Getting Index...
    
    func getIndex() -> Int {
        let index = Int(round(Double(offset / getWidth())))
        return index
    }
    
    
    ///Getting offset for Capsule Shape...
    func getOffSet() -> CGFloat {
        ///Spacing = 15
        ///Circle width = 7
        ///So total is 22
        
        let progress = offset / getWidth()
        
        return 22 * progress
    }
}


///Extending View to get Width...
extension View {
    func getWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
}
