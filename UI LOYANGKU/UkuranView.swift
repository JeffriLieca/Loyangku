//
//  UkuranView.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 05/05/24.
//

import SwiftUI

struct UkuranView: View {
    @Binding var ukuran : Shape?
    @Binding var panjang : String
    @Binding var lebar : String
    @Binding var hasil : String
    //    @Binding var keyboardFocused : FocusState<Bool>
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack{
            switch (ukuran?.rawValue){
            case "Persegi" :
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Sisi")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            case "Lingkaran" :
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Diameter")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            case "Persegi Panjang" :
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Panjang")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        VStack{
                            Text("Lebar")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM", text: $lebar)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            case "Area" :
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Area")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM2", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            case "Volume" :
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Volume")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM3", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            case "Porsi" :
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Porsi")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "Prs", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            default:
                HStack(spacing:10){
                    HStack{
                        VStack{
                            Text("Panjang")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM", text: $panjang)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    HStack{
                        VStack{
                            Text("Lebar")
                                .font(.caption)
                                .opacity(0.5)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            CustomTextFieldView(unit: "CM", text: $lebar)
                                .focused($isFocused)
                                .background(Color(red: 253/255, green: 246/255, blue: 237/255))
                                .cornerRadius(5)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .opacity(0.2)
                
                
            }
            
        }
        .onChange(of: panjang){ updateHasil() }
        .onChange(of: lebar){ updateHasil() }
        .onChange(of: ukuran){ updateHasil() }
        
    }
    
    
    func updateHasil() {
        let p = Double(panjang) ?? 0
        let l = Double(lebar) ?? 0

        switch ukuran?.rawValue {
        case "Persegi":
            hasil = "\(p * p)" // Luas persegi = sisi * sisi
        case "Lingkaran":
            let radius = p / 2
            hasil = "\(Double.pi * radius * radius)" // Luas lingkaran = π * r^2
        case "Persegi Panjang":
            hasil = "\(p * l)" // Luas persegi panjang = panjang * lebar
        case "Area":
            hasil = "\(p)" // Sementara
        case "Volume":
            // Volume tidak dihitung dalam satuan luas
            hasil = "\(p)"
        case "Porsi":
            // Porsi tidak memiliki luas
            hasil = "\(p)"
        default:
            hasil = "Undefined"
        }
    }

}

//#Preview {
//    UkuranView()
//}
