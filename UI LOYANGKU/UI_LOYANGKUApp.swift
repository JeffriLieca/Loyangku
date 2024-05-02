//
//  UI_LOYANGKUApp.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 29/04/24.
//

import SwiftUI

@main
struct UI_LOYANGKUApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBrown // Sesuaikan warna sesuai keinginan
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = UIColor.red
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

