//
//  ListTesting.swift
//  ParamountPlusSwiftUI
//
//  Created by Ho, Kenny on 4/5/21.
//

import SwiftUI
import Introspect

struct ListTesting: View {
    
    var body: some View {
        List {
            ForEach(0..<8, id: \.self) { item in
                Text(item.description)
                
            }
        }
        
        .introspectTableView(customize: { (tableView) in
            tableView.backgroundColor = .orange
        })
    }
}

struct ListTesting_Previews: PreviewProvider {
    static var previews: some View {
        ListTesting()
    }
}
