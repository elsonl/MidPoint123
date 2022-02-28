//
//  PlacesAutoComplete2.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/28/22.
//

import Foundation
import UIKit
import SwiftUI
import GooglePlaces


struct PlacesAutoComplete2: UIViewControllerRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode2
    @Binding var address2: String


    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacesAutoComplete2>) -> GMSAutocompleteViewController {

        let autocompleteController2 = GMSAutocompleteViewController()
        autocompleteController2.delegate = context.coordinator


        let fields2: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
        autocompleteController2.placeFields = fields2

        let filter2 = GMSAutocompleteFilter()
        filter2.type = .address
        filter2.type = .city
        filter2.type = .establishment
        filter2.country = "USA"
        autocompleteController2.autocompleteFilter = filter2
        return autocompleteController2
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacesAutoComplete2>) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
      

        var parent2: PlacesAutoComplete2

        init(_ parent2: PlacesAutoComplete2) {
            self.parent2 = parent2
        }

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place2: GMSPlace) {
            DispatchQueue.main.async {
                print(place2.description.description as Any)
                self.parent2.address2 =  place2.name!
                self.parent2.presentationMode2.wrappedValue.dismiss()
                
                
            }
        }
        
      

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent2.presentationMode2.wrappedValue.dismiss()
        }

    }
}
