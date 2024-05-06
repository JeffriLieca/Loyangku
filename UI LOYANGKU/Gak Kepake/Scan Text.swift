//
//  Scan Text.swift
//  UI LOYANGKU
//
//  Created by Jeffri Lieca H on 30/04/24.
//

import Foundation
import SwiftUI
import UIKit
import Vision

struct CameraView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var ingredients: [Ingredient]

    func makeUIViewController(context: Context) -> some UIViewController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraView

        init(_ parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let uiImage = info[.originalImage] as? UIImage else {
                parent.isPresented = false
                return
            }

            // Process the image
            processImage(uiImage)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }

        private func processImage(_ image: UIImage) {
            guard let cgImage = image.cgImage else {
                parent.isPresented = false
                return
            }

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            let request = VNRecognizeTextRequest { [weak self] request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                    self?.parent.isPresented = false
                    return
                }

                var newIngredients: [Ingredient] = []
                for observation in observations {
                    guard let topCandidate = observation.topCandidates(1).first else { continue }
                    let text = topCandidate.string
                    // Parse the text here to your Ingredient struct
                    let details = text.split(separator: " ")
                    if details.count >= 3 {
                        let quantity = String(details[0])
                        let unit = String(details[1])
                        let name = details.dropFirst(2).joined(separator: " ")
                        newIngredients.append(Ingredient(name: name, unit: unit, quantity: quantity))
                    }
                }

                DispatchQueue.main.async {
                    self?.parent.ingredients.append(contentsOf: newIngredients)
                    self?.parent.isPresented = false
                }
            }

            try? handler.perform([request])
        }
    }
}
