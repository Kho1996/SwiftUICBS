//
//  RelatedShow.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 4/5/21.
//

import SwiftUI
import Foundation

struct RelatedShow: Decodable, Hashable {
    let relatedShowTitle: String
    let filepath_show_logo: String
    let showAssets: ShowAsset
}
