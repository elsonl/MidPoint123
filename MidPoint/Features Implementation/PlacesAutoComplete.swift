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
    @Binding var address1 : String
    @Binding var address2 : String
    @Binding var count : Bool
    @State var placeIDThing : String
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, count: $count, placeIDThing: $placeIDThing)
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
        @Binding var placeIDThing : String
        @Binding var count : Bool
        var parent: PlacesAutoComplete

        init(_ parent: PlacesAutoComplete,count: Binding<Bool>, placeIDThing: Binding<String>) {
            self.parent = parent
            self._count = count
            self._placeIDThing = placeIDThing
        }

      

        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            placeIDThing = String(place.description.description).replacingOccurrences(of: "PlaceID: ", with: "")
            print(placeIDThing + "PLACEIDTHING - ELSON")
            DispatchQueue.main.async {
                print(place.description.description as Any)
                if self.count{
                self.parent.address1 =  place.name!
                    print("COUNT 1 BELOW")
                    print(self.count)
                }
                else {
                self.parent.address2 =  place.name!
                    print("COUNT 2 BELOW")
                    print(self.count)
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
