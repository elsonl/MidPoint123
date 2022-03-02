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
    
  
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var geocoding : Geocoding
    @Binding var address1 : String
    @Binding var address2 : String
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
   
   
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
        @EnvironmentObject var geocoding : Geocoding
        var parent: PlacesAutoComplete

        init(_ parent: PlacesAutoComplete) {
            self.parent = parent

        }

      

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            geocoding.placeIDThing = String(place.description.description).replacingOccurrences(of: "PlaceID: ", with: "")
            print(geocoding.placeIDThing + "PLACEIDTHING - ELSON")
            DispatchQueue.main.async { [self] in
                print(place.description.description as Any)
                if self.geocoding.count{
                self.parent.address1 =  place.name!
                    print("COUNT 1 BELOW")
                    print(self.geocoding.count)
                }
                else {
                self.parent.address2 =  place.name!
                    print("COUNT 2 BELOW")
                    print(self.geocoding.count)
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
