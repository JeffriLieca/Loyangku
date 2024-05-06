//
//  ModalRecipeView.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 05/05/24.
//

import Foundation
import SwiftUI
import Vision

struct ModalRecipeView: View {
    @Binding var showModal: Bool
    @Binding var resetState: Bool
    @Binding var ingredients:[Ingredient]?
//    @State private var ingredients = [
//        Ingredient(name: "Kuning Telur", unit: "", quantity: ""),
//        Ingredient(name: "Putih Telur", unit: "", quantity: "3"),
//        Ingredient(name: "Gula Pasir", unit: "gr", quantity: "150"),
//        Ingredient(name: "Tepung Terigu", unit: "gr", quantity: "40")
//    ]
    
    @State private var isEditing = false

    @State  var editingIngredient: Ingredient = Ingredient(name: "", unit: "", quantity: "")
    @State private var showEditModal = false
    @State private var showTambahModal = false
    @State private var newIngredient = Ingredient(name: "", unit: "", quantity: "")

    @State private var usePhoto = false
    
    @State private var showActionSheet = false
        @State private var showImagePicker = false
        @State private var showManualEntry = false
        @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary

    @State private var image: UIImage?
//    @State private var ingredients: [Ingredient] = []
    @State private var imagePickerPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera  // Default ke kamera
    
    
    @State private var showAlert = false

    @Binding var adaResep:Bool

    var body: some View {
        NavigationView {
            
            ScrollView{
                VStack {
                   HStack {
                        
                        
                        Button("Upload Resep", systemImage: "square.and.arrow.up") {
                            showActionSheet = true
                        }
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(title: Text("Upload Resep"), message: Text("Pilih metode untuk mengunggah resep."), buttons: [
                                .default(Text("Ambil Foto")) {
                                    sourceType = .camera
                                    imagePickerPresented = true
                                },
                                .default(Text("Pilih dari Galeri")) {
                                    sourceType = .photoLibrary
                                    imagePickerPresented = true
                                },
                                .cancel()
                            ])
                        }
                       Spacer()
                       Button("Edit", systemImage: "pencil") {
                           isEditing.toggle()
                       }
                       .foregroundColor(.white)
                       .padding(10)
                       .background(isEditing ? Color(red: 198/255, green: 159/255, blue: 108/255)
 : Color.brown)  // Ganti warna tombol saat editing
                       .clipShape(RoundedRectangle(cornerRadius: 10))

                       
                       Button("Tambah", systemImage: "plus") {
                           showTambahModal = true
                       }
                       .foregroundColor(.white)
                       .padding(10)
                       .background(.brown)
                       .clipShape(RoundedRectangle(cornerRadius: 10))
                       
                        
//                        Spacer()
                    }
                   .padding(.bottom)
                    HStack{
                        Text("Resep")
                            .font(.title3)
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom,10)
                   
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

                                if isEditing {
                                    Button(action: {
                                        editingIngredient = ingredients![index]
                                                showEditModal = true
                                            }) {
                                                Image(systemName: "pencil")
                                                    .foregroundColor(.blue)
                                            }
                                    Button(action: {
                                        ingredients?.remove(at: index)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                            Divider()
                        }
                   
                    Spacer()
                    
                }
                .sheet(isPresented: $imagePickerPresented) {
                    ImagePicker(image: $image, sourceType: $sourceType, usePhoto: $usePhoto)
                        .onAppear(){
                            usePhoto = false
                        }
                        .onDisappear {
                            if usePhoto {

                                recognizeText(from: image)
                               
                            }
                        }
                }
                
                .sheet(isPresented: $showEditModal) {
                    NavigationView {
                        Form {
                            HStack {
                                Text("Nama:")
                                    .frame(width: 80, alignment: .leading)
                                TextField("Masukan nama", text: $editingIngredient.name)
                            }

                            HStack {
                                Text("Jumlah:")
                                    .frame(width: 80, alignment: .leading)
                                TextField("Masukan jumlah", text: $editingIngredient.quantity)
                            }

                            HStack {
                                Text("Satuan:")
                                    .frame(width: 80, alignment: .leading)
                                TextField("Masukan satuan", text: $editingIngredient.unit)
                            }
                        }
                       
                        .navigationBarItems(leading: Button("Cancel") {
                            showEditModal = false
                        }, trailing: Button("Save") {
                            // Save changes here
                            if let index = ingredients!.firstIndex(where: { $0.id == editingIngredient.id }) {
                                ingredients![index] = editingIngredient
                            }
                            showEditModal = false
                        })
                        .navigationTitle("Edit Bahan")
                    }

                }
                .sheet(isPresented: $showTambahModal) {
                    NavigationView {
                        Form {
                            HStack {
                                Text("Nama:")
                                    .frame(width: 80, alignment: .leading)
                                TextField("Masukkan nama", text: $newIngredient.name)
                            }

                            HStack {
                                Text("Jumlah:")
                                    .frame(width: 80, alignment: .leading)
                                TextField("Masukkan jumlah", text: $newIngredient.quantity)
                            }

                            HStack {
                                Text("Satuan:")
                                    .frame(width: 80, alignment: .leading)
                                TextField("Masukkan satuan", text: $newIngredient.unit)
                            }
                        }
                        .navigationBarItems(leading: Button("Cancel") {
                            showTambahModal = false
                        }, trailing: Button("Tambah") {
                            // Save changes here
                            ingredients!.append(newIngredient)
                            showTambahModal = false
                            newIngredient = Ingredient(name: "", unit: "", quantity: "")  // Reset form
                        })
                        .navigationTitle("Tambah Bahan")
                    }
                }


            }
            .padding()
//            .background(.blue)
            .navigationBarItems(leading: Button("Remove") {
                adaResep = false
                showAlert = true
                resetState = true
                        }.foregroundColor(.red)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Confirm Removal"),
                        message: Text("Apakah Anda yakin mau meremove resep ini?"),
                        primaryButton: .destructive(Text("Remove")) {
                            adaResep = false
                            showModal = false
                        },
                        secondaryButton: .cancel()
                    )
                }
                                , trailing: Button("Done") {
                            // Logic to add the data goes here
                            print("Data added: ")
                            adaResep = true
                            showModal = false
                        })
                        .navigationTitle("Uploaded Resep")
                        .navigationBarTitleDisplayMode(.inline)
        }
        .background(.red)
    }
    
    private func recognizeText(from image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        let request = VNRecognizeTextRequest { request, error in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                let recognizedStrings = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }
                DispatchQueue.main.async {
                    self.ingredients! += self.parseIngredients(from: recognizedStrings.joined(separator: "\n"))
                    
                    self.showModal = true
                }
            }
        }
        request.recognitionLevel = .accurate

        let requests = [request]
        let handler = VNImageRequestHandler(cgImage: cgImage)
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform(requests)
        }
    }

    private func parseIngredients(from text: String) -> [Ingredient] {
        let lines = text.split(separator: "\n")
        var ingredients: [Ingredient] = []

        // Regex diperbarui untuk menangkap kuantitas yang opsional, unit yang opsional, dan nama
        let regexPattern = #"^(\d*\s*)([a-zA-Z]*\s*ml|gr|sdm|sdt|butir|cup|liter|buah|l|g|kg)?\s*(.*)$"#
        let regex = try! NSRegularExpression(pattern: regexPattern, options: [])

        for line in lines {
            let lineStr = String(line)
            let matches = regex.matches(in: lineStr, options: [], range: NSRange(lineStr.startIndex..., in: lineStr))

            if let match = matches.first {
                let quantityRange = Range(match.range(at: 1), in: lineStr)
                let unitRange = Range(match.range(at: 2), in: lineStr)
                let nameRange = Range(match.range(at: 3), in: lineStr)

                let quantity = quantityRange != nil ? String(lineStr[quantityRange!]) : ""
                let unit = unitRange != nil ? String(lineStr[unitRange!]) : ""
                let name = nameRange != nil ? String(lineStr[nameRange!]) : ""

                if !name.trimmingCharacters(in: .whitespaces).isEmpty { // Pastikan nama tidak kosong
                    let ingredient = Ingredient(name: name.trimmingCharacters(in: .whitespaces),
                                                unit: unit.trimmingCharacters(in: .whitespaces),
                                                quantity: quantity.trimmingCharacters(in: .whitespaces))
                    ingredients.append(ingredient)
                }
            }
        }
        return ingredients
    }
    
}
//#Preview {
//    ModalRecipeView( editingIngredient: Ingredient(name: "Kuning Telur", unit: "", quantity: ""))
//}
//
