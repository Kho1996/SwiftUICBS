//
//  ContentView.swift
//  PPlusClip
//
//  Created by Ho, Kenny on 2/8/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var model = RelatedShowModel()
    
    var body: some View {
        Text("Hello, world! (App Clip)")
            .foregroundColor(Color("primaryColor"))
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
