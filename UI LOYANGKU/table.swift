//import SwiftUI
//
//// Define the data structure
//struct Persons: Identifiable {
//    let id = UUID()
//    let givenName: String
//    let familyName: String
//    let emails: String
//}
//
//
//struct ContentVieww: View {
//    // Sample data for the table
//    @State private var people: [Persons] = [
//        Persons(givenName: "Juan", familyName: "Chavez", emails: "juanchavez@example.com"),
//        Persons(givenName: "Mei", familyName: "Chen", emails: "meichen@example.com"),
//        Persons(givenName: "Tom", familyName: "Clark", emails: "tomclark@example.com"),
//        Persons(givenName: "Gita", familyName: "Kumar", emails: "gitakumar@example.com")
//    ]
//
//    var body: some View {
//        
//        // Use a ScrollView to make the table horizontally scrollable
//        ScrollView(.horizontal) {
//            HStack {
//                // Define the table
//                Table(people) {
//                    TableColumn("Given Name", value: .givenName)
//                    { customer in
//                        VStack(alignment: .leading) {
//                            Text(customer.familyName)
//                            
//                            Text(customer.emails)
//                                .foregroundStyle(.secondary)
//                            
//                        }
//                    }
//                    .width(50)
//                    TableColumn("Family Name", value: \.familyName)
//                        .width(50)
//                    TableColumn("Email", value: \.emails)
//                        .width(50)
//                }
//                
//                
//                
//                // Set the table to take up at least the width of the ScrollView
//                .frame(minWidth: 1000)
//            }
//        }
//    }
//}
//
//
//#Preview {
//    ContentVieww()
//}
