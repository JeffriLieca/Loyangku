//
//  LoadingView.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 05/05/24.
//


import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.headline)
                .padding(.bottom, 20)
            
            ProgressView()  // Default spinner
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))  // Mengatur warna spinner
                .scaleEffect(1.5)  // Membuat spinner lebih besar
        }
    }
}
