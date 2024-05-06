//
//  CustomTextFieldView.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 05/05/24.
//

import SwiftUI

struct CustomTextFieldView: View {
    var unit: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        HStack {
            TextField("0", text: $text)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .onReceive(text.publisher.collect()) {
                    let filtered = String($0.filter { "0123456789".contains($0) })
                    if filtered.first == "0" { // Cek jika angka pertama adalah 0 dan ada lebih dari satu karakter
                        self.text = String(filtered.drop(while: { $0 == "0" })) // Hilangkan angka 0 di awal sampai angka selain 0 ditemukan
                    } else {
                        self.text = filtered // Jangan ubah jika tidak memenuhi kriteria di atas
                    }
                }
                .onTapGesture {
                    isFocused = false
                        }

                .padding()
                .frame(height: 40)
                .cornerRadius(10)
                .foregroundColor(.black)
                .tint(.black)
                .multilineTextAlignment(.leading)
            
            Divider()
                .frame(height: 25)
            
            Text(unit)
                .foregroundColor(.black)
                .opacity(0.5)
                .padding(.trailing, 10)
        }
        .background(Color(red: 253/255, green: 246/255, blue: 237/255))
        .cornerRadius(10)
    }
    
}

//#Preview {
//    CustomTextFieldView()
//}
