////
////  ModalRecipeView.swift
////  UI LOYANGKU
////
////  Created by Jeffri Lieca H on 05/05/24.
////
//
//import Foundation
//import SwiftUI
//
//struct ModalRecipeViewGeser: View {
//    @State var showModal: Bool = false
////    @Binding var ingredients:[Ingredient]?
//    @State private var ingredients = [
//        Ingredient(name: "Kuning Telur", unit: "", quantity: ""),
//        Ingredient(name: "Putih Telur", unit: "", quantity: "3"),
//        Ingredient(name: "Gula Pasir", unit: "gr", quantity: "150"),
//        Ingredient(name: "Tepung Terigu", unit: "gr", quantity: "40")
//    ]
//    
//    @State private var isEditing = false
//
//    @State  var editingIngredient: Ingredient
//    @State private var showEditModal = false
//    @State private var showTambahModal = false
//    @State private var newIngredient = Ingredient(name: "", unit: "", quantity: "")
//
//
//    
//    @State private var showActionSheet = false
//        @State private var showImagePicker = false
//        @State private var showManualEntry = false
//        @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary
//
//    @State private var image: UIImage?
////    @State private var ingredients: [Ingredient] = []
//    @State private var imagePickerPresented = false
//    @State private var sourceType: UIImagePickerController.SourceType = .camera  // Default ke kamera
//
//    func moveIngredients(from source: IndexSet, to destination: Int) {
//            ingredients.move(fromOffsets: source, toOffset: destination)
//        }
//    
//    var body: some View {
//        NavigationView {
//            
//            ScrollView{
//                VStack {
//                   HStack {
//                        
//                        
//                        Button("Upload Resep", systemImage: "square.and.arrow.up") {
//                            showActionSheet = true
//                        }
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(.brown)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .actionSheet(isPresented: $showActionSheet) {
//                            ActionSheet(title: Text("Upload Resep"), message: Text("Pilih metode untuk mengunggah resep."), buttons: [
//                                .default(Text("Ambil Foto")) {
//                                    sourceType = .camera
//                                    imagePickerPresented = true
//                                },
//                                .default(Text("Pilih dari Galeri")) {
//                                    sourceType = .photoLibrary
//                                    imagePickerPresented = true
//                                },
//                                .default(Text("Tambahkan Manual")) {
//                                    showManualEntry = true
//                                },
//                                .cancel()
//                            ])
//                        }
//                       Spacer()
//                       Button("Edit", systemImage: "pencil") {
//                           isEditing.toggle()
//                       }
//                       .foregroundColor(.white)
//                       .padding(10)
//                       .background(isEditing ? Color(red: 198/255, green: 159/255, blue: 108/255)
// : Color.brown)  // Ganti warna tombol saat editing
//                       .clipShape(RoundedRectangle(cornerRadius: 10))
//
//                       
//                       Button("Tambah", systemImage: "plus") {
//                           showTambahModal = true
//                       }
//                       .foregroundColor(.white)
//                       .padding(10)
//                       .background(.brown)
//                       .clipShape(RoundedRectangle(cornerRadius: 10))
//                       
//                        
////                        Spacer()
//                    }
//                   .padding(.bottom)
//                    HStack{
//                        Text("Resep")
//                            .font(.title3)
//                            .bold()
//                        Spacer()
//                    }
//                    .padding(.bottom,10)
////                    if ingredients != nil {
//                        NavigationView{
//                            List{
//                                ForEach(ingredients.indices, id: \.self) { index in
//                                    HStack {
//                                        if !ingredients[index].quantity.isEmpty {
//                                            Text("\(ingredients[index].quantity)")
//                                                .frame(minWidth: 50, alignment: .trailing)
//                                            Divider()
//                                        }
//                                        
//                                        if !ingredients[index].unit.isEmpty {
//                                            Text("\(ingredients[index].unit)")
//                                                .frame(minWidth: 50)
//                                            Divider()
//                                        }
//                                        
//                                        Text(ingredients[index].name)
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                        
//                                        if isEditing {
//                                            Button(action: {
//                                                editingIngredient = ingredients[index]
//                                                showEditModal = true
//                                            }) {
//                                                Image(systemName: "pencil")
//                                                    .foregroundColor(.blue)
//                                            }
//                                            Button(action: {
//                                                ingredients.remove(at: index)
//                                            }) {
//                                                Image(systemName: "minus.circle.fill")
//                                                    .foregroundColor(.red)
//                                            }
//                                        }
//                                    }
//                                    .padding(.vertical, 4)
//                                }
//                                .onMove(perform: moveIngredients)
//                            }
//                            .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
//                            .background(.red)
//                                
//                            
//                        }
//                        .padding(0)
//                        .background(Color.clear)
//                  
//                    Spacer()
//                    
//                }
//                .sheet(isPresented: $showEditModal) {
//                    NavigationView {
//                        Form {
//                            HStack {
//                                Text("Nama:")
//                                    .frame(width: 80, alignment: .leading)
//                                TextField("Masukan nama", text: $editingIngredient.name)
//                            }
//
//                            HStack {
//                                Text("Jumlah:")
//                                    .frame(width: 80, alignment: .leading)
//                                TextField("Masukan jumlah", text: $editingIngredient.quantity)
//                            }
//
//                            HStack {
//                                Text("Satuan:")
//                                    .frame(width: 80, alignment: .leading)
//                                TextField("Masukan satuan", text: $editingIngredient.unit)
//                            }
//                        }
//                       
//                        .navigationBarItems(leading: Button("Cancel") {
//                            showEditModal = false
//                        }, trailing: Button("Save") {
//                            // Save changes here
//                            if let index = ingredients.firstIndex(where: { $0.id == editingIngredient.id }) {
//                                ingredients[index] = editingIngredient
//                            }
//                            showEditModal = false
//                        })
//                        .navigationTitle("Edit Bahan")
//                    }
//
//                }
//                .sheet(isPresented: $showTambahModal) {
//                    NavigationView {
//                        Form {
//                            HStack {
//                                Text("Nama:")
//                                    .frame(width: 80, alignment: .leading)
//                                TextField("Masukkan nama", text: $newIngredient.name)
//                            }
//
//                            HStack {
//                                Text("Jumlah:")
//                                    .frame(width: 80, alignment: .leading)
//                                TextField("Masukkan jumlah", text: $newIngredient.quantity)
//                            }
//
//                            HStack {
//                                Text("Satuan:")
//                                    .frame(width: 80, alignment: .leading)
//                                TextField("Masukkan satuan", text: $newIngredient.unit)
//                            }
//                        }
//                        .navigationBarItems(leading: Button("Cancel") {
//                            showTambahModal = false
//                        }, trailing: Button("Tambah") {
//                            // Save changes here
//                            ingredients.append(newIngredient)
//                            showTambahModal = false
//                            newIngredient = Ingredient(name: "", unit: "", quantity: "")  // Reset form
//                        })
//                        .navigationTitle("Tambah Bahan")
//                    }
//                }
//
//
//            }
//            .padding()
////            .background(.blue)
//            .navigationBarItems(leading: Button("Cancel") {
//                            showModal = false
//                        }, trailing: Button("Done") {
//                            // Logic to add the data goes here
//                            print("Data added: ")
//                            showModal = false
//                        })
//                        .navigationTitle("Upload Resep")
//                        .navigationBarTitleDisplayMode(.inline)
//        }
//        .background(.red)
//    }
//}
//#Preview {
//    ModalRecipeViewGeser( editingIngredient: Ingredient(name: "Kuning Telur", unit: "", quantity: ""))
//}
//
