//
//  ContentView.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 29/04/24.
//

import SwiftUI
import Vision

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    @Binding var sourceType: UIImagePickerController.SourceType  // Default ke galeri

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType  // Gunakan sourceType yang diberikan
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


struct ContentView: View {
    @State private var selectedOption: String = "Balok"
    @State private var Length: String = ""
    @State private var Width: String = ""
    @State private var Height: String = ""
    
    @State private var image: UIImage?
//    @State private var ingredients: [Ingredient] = []
    @State private var imagePickerPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera  // Default ke kamera
    
    @State private var people = [
        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
    ]
    
    @State private var ingredients = [
        Ingredient(name: "Kuning Telur", unit: "", quantity: "12"),
        Ingredient(name: "Putih Telur", unit: "", quantity: "3"),
        Ingredient(name: "Gula Pasir", unit: "gr", quantity: "150"),
        Ingredient(name: "Tepung Terigu", unit: "gr", quantity: "40")
    ]
    
#if os(iOS)
@Environment(\.horizontalSizeClass) private var horizontalSizeClass
private var isCompact: Bool { horizontalSizeClass == .compact }
#else
private let isCompact = false
#endif

@State private var sortOrder = [KeyPathComparator(\Ingredient.name)]
    @State private var isCameraPresented = false
  
    var body: some View {
        NavigationView {
            
            //            NavigationLink(destination: Text("Detail View")) {
            //                Text("Go to Detail View")
            //            }
            ScrollView {
                VStack(alignment: .center,spacing: 0) {
                    
                    
                    // Subjudul untuk "Ukuran Loyang"
                    HStack{
                        Text("Ukuran Loyang")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal,30)
                            .padding(.top, 20)
//                            .background(.blue)
                            .foregroundColor(.brown)
                        Spacer()
                    }
                    
                    VStack{
                        HStack{
                            Text("Shape")
                                .font(.title3)
                                .fontWeight(.semibold)
    //                            .background(.blue)
                                .foregroundColor(.brown)
                            
                            Spacer()
                        }
                        Picker("Shape", selection: $selectedOption) {
                            Text("Balok").tag("Balok")
                             Text("Tabung").tag("Tabung")
                        }
                        
                        .pickerStyle(.segmented)
//                        .background(.yellow)
                        HStack(spacing: 0){
                            TextField("Length", text: $Length)
                                        .keyboardType(.numberPad) // Suggests a numeric keyboard
                                        .onReceive(Length.publisher.collect()) {
                                            // Filtering to ensure only numbers are allowed
                                            self.Length = String($0.filter { "0123456789".contains($0) })
                                        }
                                        .frame(height: 40) // Set the specific height for the TextField
                                        .background(Color(red: 210/255, green: 180/255, blue: 140/255))
                                        .cornerRadius(5) // Rounded corners
                                        .foregroundColor(.white) // Text color
                                        .tint(.white)
                                        .multilineTextAlignment(.center) // Text alignment in the center
//                                        .padding() // Menambahkan padding di sekitar TextField untuk estetika// Mengatur teks agar selalu di tengah
//                                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                    .frame(height: 40)
//                            // Tambahkan padding vertikal untuk memperbesar TextField
////                                    .border(Color.black)
////                                    .frame(width: 80)
////                                    .cornerRadius(10)
////                                    .background(.brown)
////                            .padding(0) // Menambahkan padding untuk memberi ruang di sekitar teks
//                                .background(Color.blue) // Mengatur warna background
//                                .cornerRadius(5) // Memberikan sudut yang bulat
//                                .foregroundColor(.white) // Mengatur warna teks
                                
                                
//
                            
                                    
                            
                            Text("X")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .frame(width: 30)
                            
                            TextField("Width", text: $Width)
                                .keyboardType(.numberPad) // Suggests a numeric keyboard
                                .onReceive(Width.publisher.collect()) {
                                    // Filtering to ensure only numbers are allowed
                                    self.Width = String($0.filter { "0123456789".contains($0) })
                                }
                                .frame(height: 40) // Set the specific height for the TextField
                                .background(Color(red: 210/255, green: 180/255, blue: 140/255))
                                .cornerRadius(5) // Rounded corners
                                .foregroundColor(.white) // Text color
                                .tint(.white)
                                .multilineTextAlignment(.center)

                            
                            Text("X")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .bold()
                                .frame(width: 30)
                            
                            TextField("Height", text: $Height)
                                .keyboardType(.numberPad) // Suggests a numeric keyboard
                                .onReceive(Height.publisher.collect()) {
                                    // Filtering to ensure only numbers are allowed
                                    self.Height = String($0.filter { "0123456789".contains($0) })
                                }
                                .frame(height: 40) // Set the specific height for the TextField
                                .background(Color(red: 210/255, green: 180/255, blue: 140/255)) // Set the background color
                                .cornerRadius(5) // Rounded corners
                                .foregroundColor(.white) // Text color
                                .tint(.white)
                                .multilineTextAlignment(.center)
                            
                        }
//                        .background(.red)
                        
                    }.frame(width: 300,alignment: .center)
//                        .fixedSize()
                        .padding()
                        
                        //                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                                            .background(.yellow)
                    
                    
                    // Kode selanjutnya untuk input fields...
                    
                    // Subjudul untuk "Ingredient"
                    HStack{
                        Text("Ingredient")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal,30)
                            .padding(.top, 20)
//                            .background(.blue)
                            .foregroundColor(.brown)
                        Spacer()
                    }
//                    Button("Open Camera") {
//                                   isCameraPresented = true
//                               }
//                               .fullScreenCover(isPresented: $isCameraPresented) {
//                                   CameraView(isPresented: $isCameraPresented, ingredients: $ingredients)
//                               }

                    
                    // Sebelum IngredientTable
//                    Text("Debug: Before IngredientTable")
                    HStack{
                        Button("Take Photo") {
                            sourceType = .camera
                            imagePickerPresented = true
                        }
                        .padding(.horizontal)
                        .frame(height: 40) // Set the specific height for the TextField
                        .background(Color(red: 210/255, green: 180/255, blue: 140/255)) // Set the background color
                        .cornerRadius(5) // Rounded corners
                        .foregroundColor(.white) // Text color
                        .tint(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        Button("Upload Photo") {
                            sourceType = .photoLibrary
                            imagePickerPresented = true
                        }
                        .padding(.horizontal)
                        .frame(height: 40) // Set the specific height for the TextField
                            .background(Color(red: 210/255, green: 180/255, blue: 140/255)) // Set the background color
                            .cornerRadius(5) // Rounded corners
                            .foregroundColor(.white) // Text color
                            .tint(.white)
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack {
                        ForEach(ingredients) { ingredient in
                            HStack(alignment: .center, spacing: 8) {  // Menambahkan spacing yang konsisten
                                // Tampilkan quantity jika ada
                                if !ingredient.quantity.isEmpty {
                                    Text("\(ingredient.quantity)")
                                        .frame(minWidth: 50, alignment: .trailing)  // Mengatur lebar minimum dan alignment ke kiri
                                    Divider()
                                }
                                
                                // Tampilkan unit jika ada
                                if !ingredient.unit.isEmpty {
                                    Text("\(ingredient.unit)")
                                        .frame(minWidth: 50)
                                    Divider()
                                }
                                
                                // Selalu tampilkan nama
                                Text(ingredient.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)  // Memastikan nama selalu di kiri setelah quantity dan unit
                                
                                Spacer()  // Spacer untuk mendorong semua teks ke kiri
                            }
                            .padding(.vertical, 4)  // Padding vertikal untuk setiap baris
                            Divider()
                        }
                    }
                    .foregroundColor(.black)
                    .padding()  // Padding untuk seluruh VStack

                    

                   
                    
//                    IngredientTable(ingredients: $ingredients)
//                        .background(Color.clear)
//                   
                    
                    // Setelah IngredientTable
//                    Text("Debug: After IngredientTable")

                    // Kode selanjutnya untuk input fields...
                }
            }
            .background(.white)
            
            .navigationBarTitle("Convert Recipe", displayMode: .large)
            //            .navigationBarItems(leading: Button(action: {
            //                print("Leading item tapped")
            //            }) {
            //                Text("Left Button")
            //            }, trailing: Button(action: {
            //                print("Trailing item tapped")
            //            }) {
            //                Text("Right Button")
            //            })
            
            
        }
        .background(.blue)
        .sheet(isPresented: $imagePickerPresented) {
            ImagePicker(image: $image, sourceType: $sourceType)
                .onDisappear {
                    recognizeText(from: image)
                }
        }
    }
    
    private func recognizeText(from image: UIImage?) {
        guard let cgImage = image?.cgImage else { return }
        let request = VNRecognizeTextRequest { request, error in
            if let observations = request.results as? [VNRecognizedTextObservation] {
                let recognizedStrings = observations.compactMap { observation in
                    observation.topCandidates(1).first?.string
                }
                DispatchQueue.main.async {
                    self.ingredients = self.parseIngredients(from: recognizedStrings.joined(separator: "\n"))
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
struct Ingredient: Identifiable {
    let name: String
    let unit: String
    let quantity: String
    let id = UUID()
}




//
//struct Person: Identifiable {
//    let givenName: String
//    let familyName: String
//    let emailAddress: String
//    let id = UUID()
//
//
//    var fullName: String { givenName + " " + familyName }
//}
//
//
//
//
//
//struct PeopleTable: View {
//    @State private var people = [
//        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
//        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
//        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
//        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
//    ]
//    var body: some View {
//        Table(people) {
//            TableColumn("Given Name", value: \.givenName)
//            TableColumn("Family Name", value: \.familyName)
//            TableColumn("E-Mail Address", value: \.emailAddress)
//        }
//    }
//}





struct Customer: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let creationDate: Date
}

//struct ContentView: View {
//    @State var customers = [Customer(name: "John Smith",
//                                     email: "john.smith@example.com",
//                                     creationDate: Date() + 100),
//                            Customer(name: "Jane Doe",
//                                     email: "jane.doe@example.com",
//                                     creationDate: Date() - 3000),
//                            Customer(name: "Bob Johnson",
//                                     email: "bob.johnson@example.com",
//                                     creationDate: Date())]
//    var body: some View {
//        Table(customers) {
//            TableColumn("name", value: \.name)
//            TableColumn("email", value: \.email)  
//            TableColumn("joined at") { customer in
//                Text(customer.creationDate, style: .date)
//            }
//        }
//        Table(of: Customer.self) {
//         TableColumn("name", value: \.name)
//         TableColumn("email", value: \.email)
//         TableColumn("joined at") { customer in
//         Text(customer.creationDate, style: .date)
//         }
//        } rows: {
//            TableRow(Customer(name: "static customer",
//                              email: "fake email",
//                              creationDate: Date()))
//        }
//    }
//}

//struct ContentView: View {
//
//}

//struct CompactableTable: View {
//    @State private var people = [
//        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
//        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
//        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
//        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
//    ]
//    
//    @State private var ingredients = [
//        Ingredient(Name: "Kuning Telur", Unit: nil, Quantity: 12),
//        Ingredient(Name: "Putih Telur", Unit: nil, Quantity: 3),
//        Ingredient(Name: "Gula Pasir", Unit: "gr", Quantity: 150),
//        Ingredient(Name: "Tepung Terigu", Unit: "gr", Quantity: 40)
//        
//    ]
//    
//    #if os(iOS)
//    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
//    private var isCompact: Bool { horizontalSizeClass == .compact }
//    #else
//    private let isCompact = false
//    #endif
//
//
//    @State private var sortOrder = [KeyPathComparator(\Person.givenName)]
//
//
//    var body: some View {
//        Table(people, sortOrder: $sortOrder) {
//            TableColumn("Given Name", value: \.givenName) { person in
//                HStack {
//                    Text(person.givenName)
//                        .frame(width: 50, height: 60)
////                    Spacer(minLength: 20) // Menambahkan spasi minimum antara nama dan detail
//                        
//                    Divider().frame(height: 50)
//                    if isCompact {
//                        VStack(alignment: .leading) {
//                            Text(person.familyName)
//                            Text(person.emailAddress)
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    Spacer() // Menambahkan spacer di akhir untuk mendorong semua konten ke kiri
//                }
//            }
//            TableColumn("Family Name", value: \.familyName)
//            TableColumn("E-Mail Address", value: \.emailAddress)
//        }
//        .onChange(of: sortOrder) { _, sortOrder in
//            people.sort(using: sortOrder)
//        }
//    }
//}

//#Preview {
//    CompactableTable()
//}

struct Person: Identifiable {
    let givenName: String
    let familyName: String
    let emailAddress: String
    let id = UUID()


    var fullName: String { givenName + " " + familyName }
}






//struct PeopleTable: View {
//    @State private var people = [
//        Person(givenName: "Juan", familyName: "Chavez", emailAddress: "juanchavez@icloud.com"),
//        Person(givenName: "Mei", familyName: "Chen", emailAddress: "meichen@icloud.com"),
//        Person(givenName: "Tom", familyName: "Clark", emailAddress: "tomclark@icloud.com"),
//        Person(givenName: "Gita", familyName: "Kumar", emailAddress: "gitakumar@icloud.com")
//    ]
//    var body: some View {
//        Table(people) {
//            TableColumn("Given Name", value: \.givenName)
//            TableColumn("Family Name", value: \.familyName)
//            TableColumn("E-Mail Address", value: \.emailAddress)
//        }
//    }
//}


struct IngredientTable: View {
    
    @Binding var ingredients: [Ingredient]
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool { horizontalSizeClass == .compact }
    #else
    private let isCompact = false
    #endif

    @State private var sortOrder = [KeyPathComparator(\Ingredient.name)]

    var body: some View {
        Table(ingredients, sortOrder: $sortOrder) {
            TableColumn("Name", value: \.name) { ingredient in
                HStack {
                    Text(ingredient.quantity)
                        .frame(width: 50, height: 40)
                        .background(Color.clear)
                    Divider().frame(height: 40)
                        .background(Color.clear)
                    if isCompact {
                        VStack(alignment: .leading) {
                            Text(ingredient.name)
                            Text(ingredient.unit)
                                .foregroundColor(.secondary)
                        }
                        .background(Color.clear)
                    }
                    Spacer()
                        .background(Color.clear)// Menambahkan spacer di akhir untuk mendorong semua konten ke kiri
                }.background(Color.clear)
            }
        }
        .background(Color.clear)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
        .background(Color.clear) // Background transparan

        .onChange(of: sortOrder) { _, sortOrder in
            ingredients.sort(using: sortOrder)
        }
    }
}


#Preview {
    ContentView()
}

//struct Ingredient: Identifiable {
//    let Name: String
//    let Unit: String
//    let Quantity: String
//    let id = UUID()
//}

//@State private var ingredients = [
//    Ingredient(Name: "Kuning Telur", Unit: "gr", Quantity: "12"),
//    Ingredient(Name: "Putih Telur", Unit: "gr", Quantity: "3"),
//    Ingredient(Name: "Gula Pasir", Unit: "gr", Quantity: "150"),
//    Ingredient(Name: "Tepung Terigu", Unit: "gr", Quantity: "40")
//]


struct CustomTextField: UIViewRepresentable {
    var placeholder: String
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.backgroundColor=UIColor.brown
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
    }
}


struct NumericTextField: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.delegate = context.coordinator
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: NumericTextField

        init(_ textField: NumericTextField) {
            self.parent = textField
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Periksa apakah teks baru hanya berisi angka
            let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            return newText.isEmpty || newText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}
