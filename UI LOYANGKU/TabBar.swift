//
//  TabBar.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 03/05/24.
//

import SwiftUI
import Foundation

struct TabBarView : View {
    var body: some View {
        TabView {
            ViewBaru()
                .tabItem {
                    Label("Convert", systemImage: "arrow.left.arrow.right")
                }
                .background(.yellow)
                .tag(1)
            
            
            Text("My Recipe")
                .tabItem {
                    Label("My Recipe", systemImage: "book.closed")
                }
            
                .tag(2)
        }
        .accentColor(.brown)
    }
}
