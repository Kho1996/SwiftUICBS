//
//  LightHostingController.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 3/29/21.
//

import SwiftUI


class LightHostingController<ContentView> : UIHostingController<ContentView> where ContentView : View {
    override dynamic open var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

