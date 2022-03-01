//
//  PlacesAutoComplete.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/28/22.
//

import Foundation
import UIKit
import SwiftUI
import GooglePlaces


struct PlacesAutoComplete: UIViewControllerRepresentable {

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
   
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address1 : String
    @Binding var address2 : String
    @State var placeIDThing : String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacesAutoComplete>) -> GMSAutocompleteViewController {

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator


        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
      
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()
        filter.type = .address
        filter.type = .city
        filter.type = .establishment
        filter.country = "USA"
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }

    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacesAutoComplete>) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
      

        var parent: PlacesAutoComplete

        init(_ parent: PlacesAutoComplete) {
            self.parent = parent
        }

      
        var count = true

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//            placeIDThing = "place.description.description".replacingOccurrences(of: "PlaceID ", with: "")
            DispatchQueue.main.async {
                print(place.description.description as Any)
                if self.count == true{
                self.parent.address1 =  place.name!
                    self.count.toggle()
                }
                else if self.count == false {
                self.parent.address2 =  place.name!
                    self.count.toggle()
                }
                self.parent.presentationMode.wrappedValue.dismiss()
            }
        }

        
      

        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }

        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

    }
}
