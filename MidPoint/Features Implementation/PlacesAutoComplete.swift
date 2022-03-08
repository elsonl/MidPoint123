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
        Coordinator(self, ACCount: ($geocoding.count), geocoding : geocoding)
        
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
        
        @Binding var ACCount : Bool
        
        var parent: PlacesAutoComplete
        
        init(_ parent: PlacesAutoComplete, ACCount : Binding<Bool>, geocoding : Geocoding) {
            self.parent = parent
            self._ACCount = ACCount
            self.geocoding = geocoding
            
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

            
            DispatchQueue.main.async { [self] in
                print(place.description.description as Any)
                if self.ACCount == true{
                    
                    geocoding.placeIDThing  = place.placeID!
                    self.parent.address1 =  place.name!
                    
                }
                if self.ACCount == false {
                    
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
