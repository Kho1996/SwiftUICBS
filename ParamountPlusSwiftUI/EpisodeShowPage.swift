//
//  EpisodeShowPage.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 4/4/21.
//

import SwiftUI

var maxHeight = UIScreen.main.bounds.height / 2.3

struct EpisodeShowPage: View {
    
    var episodes = [
        Episode(imageName: "", episodeDescription: "1. The Algae's Always Greener/Spongeguard on D..."),
        Episode(imageName: "", episodeDescription: "2. Club Spongebob/My Pretty Seahorse"),
        Episode(imageName: "", episodeDescription: "3. The Bully/Just One Bite"),
        Episode(imageName: "", episodeDescription: "4. The Nasty Patty/The Idiot Box"),
        Episode(imageName: "", episodeDescription: "5. Mermaidman and Barnacle Boy IV/Doing Time"),
        Episode(imageName: "", episodeDescription: "6. The Snowball Effect/One Krab's Trash"),
        Episode(imageName: "", episodeDescription: "7. As Seen On TV/Can You Spare A Dime"),]
    
    
    private func getScale(proxy: GeometryProxy) -> CGFloat {
        var scale: CGFloat = 1
        
        let y = proxy.frame(in: .global).minY
        
        let diff = abs(y)
        print("Diff: ", diff)

        if y < 367 {
            scale = 1 + (100 + diff) / 500
        }
        
        print("Scale: ", scale)
        return scale
    }
    
    var body: some View {
        
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
            
            ///Spacing for the ForEach rows
            VStack(spacing: 0) {
                GeometryReader { reader -> AnyView in
                    
                    
                    let y = reader.frame(in: .global).minY + maxHeight
                    print("OriginalY", y)
                    
                    var scale: CGFloat = 1
                    
                    ///If Rows is dragged down, scale wont get enlarged
                    if y < 367 {
                        scale = getScale(proxy: reader)
                    } else {
                        
                        
                        scale = 1.2
                    }
                    
                    print("ScrollView y value: ", y)
                    
                    return AnyView(
                        Image("Spongebob_Background")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: screenWidth)
                            .frame(height: maxHeight)
                            
                        
                            .scaleEffect(CGSize(width: scale, height: scale))
                        
                        ///Avoid bottom scroll...Why is negative reader is what avoids bottom scrolling of image?
                            .offset(y: -reader.frame(in: .global).minY)
                            .padding(.leading, 8)
                            .padding(.top, 90)
                    )
                }
                .frame(height: maxHeight)
                
                //Rows
                ForEach(episodes, id: \.self) { episode in
                    EpisodeRow(description: episode.episodeDescription)
                }
                
                .padding(.vertical)
                .background(Color(UIColor(named: "DarkMatter") ?? .red))
                 
            }
        })
    }
}

struct EpisodeShowPage_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeShowPage()
    }
}
