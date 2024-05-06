//
//  ViewBaru.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 05/05/24.
//

import SwiftUI
import Vision

struct ViewBaru: View {
    @State private var isActive = false
    @State private var selectedShapes: String = "Persegi"
    var shapes = ["Persegi", "Persegi Panjang","Lingkaran"]
    @State var selectedShape: Shape?
    @State var panjang: String = ""
    @State var lebar: String = ""
    @State var hasil : String = ""
    
    @State var selectedShapeBaru: Shape?
    @State var panjangBaru: String = ""
    @State var lebarBaru: String = ""
    @State var hasilBaru : String = ""
    
    @State private var showActionSheet = false
        @State private var showImagePicker = false
        @State private var showManualEntry = false
        @State private var imageSource: UIImagePickerController.SourceType = .photoLibrary

    @State private var image: UIImage?
//    @State private var ingredients: [Ingredient] = []
    @State private var imagePickerPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera  // Default ke kamera
    
    @State var ingredients:[Ingredient]?
    @State private var showModal = false
    @State private var usePhoto = false
    @State private var adaResep = false
    
    @State private var navigateToDetail = false
    @FocusState private var keyboardFocused: Bool
    @State private var isLinkActivated = false
    @State var resetState: Bool = false
    
    @State private var convertedIngredients: [Ingredient]?
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    ZStack{
                        VStack(spacing:0){
                            //                    Text("Recipe Converter")
                            //                        .frame(maxWidth: .infinity, alignment: .leading)
                            //                        .font(.largeTitle)
                            //                        .fontWeight(.bold)
                            //                        .padding()
                            //                        .padding(.top)
                            //                        .padding(.top)
                            //                        .background(Color(red: 255/255, green: 255/255, blue: 247/255))
                            VStack (spacing: 0){
                                
                                HStack{
                                    Text("Loyang Sesuai Resep")
                                        .font(.title3)
                                        .bold()
                                    Spacer()
                                }
                                .padding(.vertical)
                                HStack{
                                    Text("Bentuk Loyang")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                }
                                .padding(.bottom,10)
                                HStack{
                                    CustomPicker(selection: $selectedShape,panjangnya:$panjang,lebarnya:$lebar) {
                                        Shape.allCases
                                    }
                                }
                                .zIndex(2)
                                .padding(.bottom)
                                HStack{
                                    Text("Ukuran")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                }
                                .padding(.bottom,10)
                                UkuranView(ukuran: $selectedShape, panjang: $panjang, lebar: $lebar,hasil: $hasil)
                                    .focused($keyboardFocused)
                                    .padding(.bottom)
                                
                                //                            Text(hasil)
                                //                            if Double(hasil)==0 {
                                //                                Text("ga bisa")
                                //                            }
                                
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2)
                                    .background(.red)
                                    .padding(.vertical,0)
                                
                                
                                
                            }
                            .zIndex(2)
                            
                            .padding(.horizontal)
                            .padding(.horizontal)
                            
                            VStack (spacing: 0){
                                
                                HStack{
                                    Text("Loyang Baru")
                                        .font(.title3)
                                        .bold()
                                    Spacer()
                                }
                                .padding(.bottom)
                                HStack{
                                    Text("Bentuk Loyang")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                }
                                .padding(.bottom,10)
                                HStack{
                                    
                                    if let category = selectedShape?.category {
                                        CustomPicker(selection: $selectedShapeBaru,panjangnya:$panjangBaru,lebarnya:$lebarBaru) {
                                            Shape.allCases.filter { $0.category == category }
                                        }
                                    }
                                    else {
                                        CustomPicker(selection: $selectedShapeBaru, panjangnya: $panjangBaru, lebarnya: $lebarBaru) {
                                            Shape.allCases
                                        }.disabled(true)
                                    }
                                }
                                .zIndex(1)
                                .padding(.bottom)
                                HStack{
                                    Text("Ukuran")
                                        .font(.subheadline)
                                    
                                    Spacer()
                                }
                                .padding(.bottom,10)
                                UkuranView(ukuran: $selectedShapeBaru, panjang: $panjangBaru, lebar: $lebarBaru, hasil:$hasilBaru)
                                    .focused($keyboardFocused)
                                    .padding(.bottom)
                                
                                //                            Text(hasilBaru)
                                //                            if Double(hasil)==0 {
                                //                                Text("ga bisa")
                                //                            }
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(height: 2)
                                    .background(.red)
                                    .padding(.vertical,0)
                                
                                
                            }
                            .zIndex(1)
                            .padding(.top)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            
                            VStack (spacing: 0){
                                
                                HStack{
                                    Text("Resep")
                                        .font(.title3)
                                        .bold()
                                    Spacer()
                                }
                                .padding(.bottom,10)
                                
                                HStack{
                                    
                                    
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
                                            //                                        .default(Text("Tambahkan Manual")) {
                                            //                                            showManualEntry = true
                                            //                                        },
                                                .cancel()
                                        ])
                                    }
                                    if adaResep {
                                        Button(action: {
                                            showModal = true
                                        }) {
                                            Image(systemName: "doc.text.fill")
                                                .font(.title)
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.brown)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                        }
                                    }
                                    
                                    
                                    Spacer()
                                }
                                .padding(.bottom,30)
                                
                                
                                
                                
                                
                                Button("Convert") {
                                    convertedIngredients=convertIngredients(ingredients: ingredients!, ukuranLama: hasil, ukuranBaru: hasilBaru)
                                    isLinkActivated = true
                                }
                                .disabled(Double(hasil)==0 || Double(hasilBaru)==0 || !adaResep)
                                                                                                 .font(.headline)
                                                                                                 .frame(height: 40)
                                                                                                 .frame(maxWidth: .infinity)
                                                                                                 .foregroundColor(.white)
                                                                                                 .padding(10)
                                                                                                 .background(Double(hasil)==0 || Double(hasilBaru)==0 || !adaResep ? Color.gray : Color(red: 73/255, green: 54/255, blue: 29/255))
                                                                                                 .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .zIndex(0)
                            .padding(.top)
                            .padding(.horizontal)
                            .padding(.horizontal)
                            
                            //                        NavigationLink(destination: {
                            //
                            //                            RecipeDetailView(hasil: hasil)
                            //
                            //                                    }, label: {
                            //
                            //                                        Text("Convert")
                            //
                            //                                                        .font(.headline)
                            //                                                        .frame(height: 40)
                            //                                                        .frame(maxWidth: .infinity)
                            //                                                        .foregroundColor(.white)
                            //                                                        .padding(10)
                            //                                                        .background(Double(hasil)==0 || Double(hasilBaru)==0 || !adaResep ? Color.gray : Color(red: 73/255, green: 54/255, blue: 29/255))
                            //                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                            //                                    })
                            //                        .disabled(Double(hasil)==0 || Double(hasilBaru)==0 || !adaResep)
                            Spacer()
                        }
                        .sheet(isPresented: $showImagePicker) {
                            Text ("Scan Text")
                        }
                        
                    }
                    .background(.white)
                    //            .navigationBarTitle("Convert Recipe", displayMode: .large)
                    .navigationTitle("Recipe Converter")
                    
                    NavigationLink(
                        destination: RecipeDetailView(ingredients: convertedIngredients, areaLoyangLama: Double(hasil) ?? 0, areaLoyangBaru: Double(hasilBaru) ?? 0, resetState:$resetState),
                        isActive: $isLinkActivated // Gunakan isActive di sini
                    ) {
                        EmptyView()
                    }
                    
                }
                .gesture(TapGesture().onEnded {keyboardFocused = false})
                .onTapGesture {
                    keyboardFocused = false
                        }

            }
            .onChange(of: resetState) { newValue in
                if newValue {
                    // Reset semua nilai yang relevan
                    ingredients = []
                    selectedShape = nil
                    panjang = ""
                    lebar = ""
                    hasil = ""
                    selectedShapeBaru = nil
                    panjangBaru = ""
                    lebarBaru = ""
                    hasilBaru = ""
                    adaResep = false
                    resetState = false  // Reset flag
                }
            }
            
        }
        .onAppear {
                    if isActive {
                        resetState = true
                    }
                    isActive = true
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
        .sheet(isPresented: $showModal) {
            ModalRecipeView(showModal: $showModal,resetState :$resetState, ingredients:$ingredients,adaResep: $adaResep)
                }
       
        //            Spacer()
        //        }
        
    }
    
    
    // function
    
    private func recognizeText(from image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        let request = VNRecognizeTextRequest { request, error in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                let recognizedStrings = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }
                DispatchQueue.main.async {
                    self.ingredients = self.parseIngredients(from: recognizedStrings.joined(separator: "\n"))
                    
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
    
    func convertIngredients(ingredients: [Ingredient], ukuranLama: String, ukuranBaru: String) -> [Ingredient] {
        let conversionRatio = (Double(ukuranBaru) ?? 1)/(Double(ukuranLama) ?? 1)
        return ingredients.map { ingredient in
            var newIngredient = ingredient
            if let quantityDouble = Double(ingredient.quantity) {
                // Mengkonversi quantity dan menyimpannya kembali sebagai string
                let newQuantity = quantityDouble * conversionRatio
                newIngredient.quantity = String(format: "%.2f", newQuantity)
            }
            return newIngredient
        }
    }
    
}
        
//enum Shape: String, CaseIterable, Identifiable {
//    case persegi = "Persegi"
//    case lingkaran = "Lingkaran"
//    case ppanjang = "Persegi Panjang"
//    case area = "Area"
//    case volume = "Volume"
//    case porsi = "Porsi"
//
//    var id: String { self.rawValue }
//}

enum Shape: String, CaseIterable, Identifiable {
    case persegi = "Persegi"
    case lingkaran = "Lingkaran"
    case ppanjang = "Persegi Panjang"
    case area = "Area"
    case volume = "Volume"
    case porsi = "Porsi"

    var id: String { self.rawValue }

    var category: Category {
        switch self {
        case .persegi, .lingkaran, .ppanjang, .area:
            return .area
        case .volume:
            return .volume
        case .porsi:
            return .porsi
        }
    }

    enum Category {
        case area
        case porsi
        case volume
    }
}




#Preview {
    ViewBaru()
}

//struct RecipeDetailView: View {
//   @State var ingredients: [Ingredient]
//    @State var areaLoyangLama: Double
//    @State var areaLoyangBaru: Double
//
//    var body: some View {
//        VStack {
//            Text("Hasil Konversi Resep:")
//                .font(.title)
//            ForEach(ingredients, id: \.id) { ingredient in
//                let areaRatio = areaLoyangBaru / areaLoyangLama
//                let convertedQuantity = ingredient.convertedQuantity(areaRatio: areaRatio)
//                Text("\(ingredient.name): \(convertedQuantity) \(ingredient.unit)")
//            }
//        }
//        .navigationTitle("Resep Baru")
//    }
//}


struct Ingredient: Identifiable {
 
    var name: String
    var unit: String
    var quantity: String
    let id = UUID()
    
    // Menghitung jumlah yang dikonversi ke double untuk kalkulasi
    func convertedQuantity(areaRatio: Double) -> String {
        if let quantityDouble = Double(quantity) {  // Coba konversi ke Double
            let convertedValue = quantityDouble * areaRatio  // Lakukan konversi berdasarkan rasio area
            if floor(convertedValue) == convertedValue {
                // Jika hasil konversi adalah bilangan bulat, tampilkan tanpa desimal
                return String(format: "%.0f", convertedValue)
            } else {
                // Jika hasil konversi bukan bilangan bulat, tampilkan dengan dua desimal
                return String(format: "%.2f", convertedValue)
            }
        } else {
            return quantity  // Jika konversi gagal, kembalikan jumlah asli
        }
    }
}
