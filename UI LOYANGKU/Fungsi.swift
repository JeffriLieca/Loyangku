////
////  Fungsi.swift
////  UI LOYANGKU
////
////  Created by Jeffri Lieca H on 06/05/24.
////
//
//import Foundation
//import SwiftUI
//import CoreData
//
//func saveRecipe(name: String, ingredientsDetails: [(name: String, quantity: String, unit: String)], dishShape: String, dishPanjang: String ,dishLebar: String, context: NSManagedObjectContext) {
//    let newRecipe = ConvertedRecipe(context: context)
//    newRecipe.name = name
//    newRecipe.dateCreated = Date()
//
//    let bakingDish = BakingDish(context: context)
//    bakingDish.shape = dishShape
//    bakingDish.panjang = dishPanjang
//    bakingDish.lebar = dishLebar
//    newRecipe.bakingDish = bakingDish
//
//    for ingredientDetail in ingredientsDetails {
//        let ingredient = Ingredient(context: context)
//        ingredient.name = ingredientDetail.name
//        ingredient.quantity = ingredientDetail.quantity
//        ingredient.unit = ingredientDetail.unit
//        ingredient.recipe = newRecipe
//        newRecipe.addToIngredients(ingredient)
//    }
//
//    do {
//        try context.save()
//        print("Recipe saved successfully")
//    } catch {
//        print("Failed to save recipe: \(error)")
//    }
//}
