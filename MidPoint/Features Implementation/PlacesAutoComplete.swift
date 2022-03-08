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
    
    @EnvironmentObject var geocoding : Geocoding
    @Environment(\.presentationMode) var presentationMode
    @Binding var address1 : String
    @Binding var address2 : String
    
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, geocoding : geocoding)
        
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacesAutoComplete>) -> GMSAutocompleteViewController {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
 
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue))
        
        autocompleteController.placeFields = fields

        let filter = GMSAutocompleteFilter()

        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacesAutoComplete>) {
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate, ObservableObject {
        var geocoding : Geocoding
        
        
        var parent: PlacesAutoComplete
        
        init(_ parent: PlacesAutoComplete, geocoding : Geocoding) {
            self.parent = parent
            self.geocoding = geocoding
            
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

            
            DispatchQueue.main.async { [self] in
                print(place.description.description as Any)
                if geocoding.count == true{
                    
                    geocoding.count = true
                    print("in AC below true")
                    print(geocoding.count)
                    
                    geocoding.placeIDThing  = place.placeID!
                    self.parent.address1 =  place.name!
                    
                }
                if geocoding.count == false {
                    
                    geocoding.count = false
                    print("in AC below false")
                    print(geocoding.count)
                    
                    geocoding.placeIDThing  = place.placeID!
                    self.parent.address2 =  place.name!
                    
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
