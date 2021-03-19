//
//  RecommendationPage.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/17/21.
//

import SwiftUI
import Kingfisher

struct RSS: Decodable {
    var relatedShows: [RelatedShow]
}

struct RelatedShow: Decodable, Hashable {
    let relatedShowTitle: String
    let filepath_show_logo: String
    let showAssets: ShowAsset
}

struct ShowAsset: Decodable, Hashable {
    let filepath_show_browse_poster: String
}


///                            let baseAssetUrl = "https://wwwimage-us.pplusstatic.com/thumbnails/photos/w292/"
class GridViewModel: ObservableObject {
    @Published var relatedShows = [RelatedShow]()
    
    init() {
        ///JSON decoding
        guard let url = URL(string: "https://www.paramountplus.com/apps-api/v2.0/iphone/shows/61456636/related/shows.json?at=ABA1MDI2NjA5OTMxMDIyMDkxwRcWm59UKGop9Z82DvhZ0T6JZK2xgxMFltBzNSGzU0PLk4irJgB3Ra5ysgAPplCi&locale=en-US")  else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(RSS.self, from: data)
                DispatchQueue.main.async {
                    self.relatedShows = json.relatedShows
                    print(self.relatedShows)
                    self.relatedShows.forEach { (show) in
                        let posterUrl = show.showAssets.filepath_show_browse_poster
                        print("PosterURL: \n", posterUrl)
                    }
                }
                
            } catch {
                print("Failed to decode:", error)
            }
        }.resume()
    }
}

struct RecommendationPage: View {
    
    
    
    var body: some View {
        ScrollView {
            RelatedShowsGrid()
        }
        
        .background(Color.black)
        .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
        
    }
}

struct RecommendationPage_Previews: PreviewProvider {
    static var previews: some View {
        RecommendationPage()
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}


struct RelatedShowsGrid: View {
    @ObservedObject var viewModel = GridViewModel()
    
    let columns = [
        ///Spacing is the spacing between grids - horizontal
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16),
        GridItem(.flexible(minimum: 100, maximum: 200), spacing: 16),
        GridItem(.flexible(minimum: 100, maximum: 200))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 8, content: {
            ForEach(viewModel.relatedShows, id: \.self) { item in
                HStack {
                    VStack {
                        let URLString = "https://wwwimage-us.pplusstatic.com/thumbnails/photos/w292/\(item.showAssets.filepath_show_browse_poster)"
                        
                        ///Since URLstring contains word "files" within JSON we need to replace it.
                        let replacedString = URLString.replacingOccurrences(of: "files", with: "")
                        
                        let webImageUrl = URL(string: replacedString)
                        
                        KFImage(webImageUrl)
                            .resizable()
                            .scaledToFill()
                            .background(Color.yellow)
                            .frame(width: 100, height: 180)
                    }
                }
                .background(Color.blue)
            }
        })
        
        .padding(.horizontal)
    }
}
