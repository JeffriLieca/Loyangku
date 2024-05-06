//
//  RecipeBaruView.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 06/05/24.
//

import SwiftUI

struct RecipeDetailView: View {
   @State var ingredients: [Ingredient]?
    @State var areaLoyangLama: Double
    @State var areaLoyangBaru: Double
    
    @Binding var resetState: Bool
//    @State private var convertedIngredients: [Ingredient] = []
    
//    @State private var ingredients = [
//        Ingredient(name: "Kuning Telur", unit: "", quantity: ""),
//        Ingredient(name: "Putih Telur", unit: "", quantity: "3"),
//        Ingredient(name: "Gula Pasir", unit: "gr", quantity: "150"),
//        Ingredient(name: "Tepung Terigu", unit: "gr", quantity: "40")
//    ]
    @Environment (\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            
            
            ScrollView{
                
                VStack (spacing: 0){
                    
                    
                    
                    HStack{
                        Spacer()
                        
                        
                        Button("Save", systemImage: "square.and.arrow.down") {
                            resetState = true
                            presentationMode.wrappedValue.dismiss()
                            print("Saved")
                        }
                        .frame(width: 100)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        
                        
                        Spacer()
                        Button("Done") {
                            resetState = true
                            presentationMode.wrappedValue.dismiss()
                        }
                        .frame(width: 100)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        Spacer()
                    }
                    
                    .padding(.bottom,20)
                    
                    HStack{
                        Text("Resep")
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom,20)
                }
                
                ForEach(ingredients!.indices, id: \.self) { index in
                    HStack {
                        if !ingredients![index].quantity.isEmpty {
                            Text("\(ingredients![index].quantity)")
                                .frame(minWidth: 50, alignment: .trailing)
                            Divider()
                        }
                        
                        if !ingredients![index].unit.isEmpty {
                            Text("\(ingredients![index].unit)")
                                .frame(minWidth: 50) 
                            Divider()
                        }
                        
                        Text(ingredients![index].name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(1)  // Membatasi teks ke satu baris saja
                            .truncationMode(.tail)  // Memotong teks di akhir jika tidak muat
                            .fixedSize(horizontal: false, vertical: true)
                        
                        
                    }
                    .padding(.vertical, 4)
                    Divider()
                }
            }
            
        }
        .padding()
        .padding(.horizontal)
        .navigationTitle("Resep Baru")
        .navigationBarItems(trailing: Button("Done") {
            resetState = true
            presentationMode.wrappedValue.dismiss()
        })
    }

    func convertIngredients(ingredients: [Ingredient], ukuranLama: String, ukuranBaru: String) -> [Ingredient] {
        let conversionRatio = (Double(ukuranBaru) ?? 1)/(Double(ukuranLama) ?? 1)
        return ingredients.map { ingredient in
            var newIngredient = ingredient
            if let quantityDouble = Double(ingredient.quantity) {
                // Mengkonversi quantity dan menyimpannya kembali sebagai string
                let newQuantity = quantityDouble * conversionRatio
                if newQuantity == Double(Int(newQuantity)){
                    newIngredient.quantity = String(Int(newQuantity))
                }
                else{
                    newIngredient.quantity = String(format: "%.2f", newQuantity)
                }
//                if Double(newIngredient.quantity) == Double(Int(newIngredient.quantity)!){
//                    newIngredient.quantity=String(Int(newIngredient.quantity)!)
//                }
            }
            
            return newIngredient
        }
    }


}
//#Preview {
//    RecipeDetailView()
//}



