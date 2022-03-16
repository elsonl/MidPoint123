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
    @EnvironmentObject var dMatrix : DistanceMatrix
    @EnvironmentObject var placeDetail : PlaceDetail
    @Environment(\.presentationMode) var presentationMode
    @Binding var address1 : String
    @Binding var address2 : String
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, geocoding : geocoding, dMatrix: dMatrix, address1: $address1, address2: $address2, placeDetail: placeDetail, oneArray : ["","","",""], twoArray: ["","","",""])
        
    }
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacesAutoComplete>) -> GMSAutocompleteViewController {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue) |
                                                    UInt(GMSPlaceField.phoneNumber.rawValue) |
                                                    UInt(GMSPlaceField.formattedAddress.rawValue) |
                                                    UInt(GMSPlaceField.rating.rawValue) |
                                                    UInt(GMSPlaceField.openingHours.rawValue) |
                                                    UInt(GMSPlaceField.priceLevel.rawValue) |
                                                    UInt(GMSPlaceField.website.rawValue) |
                                                    UInt(GMSPlaceField.userRatingsTotal.rawValue) |
                                                    UInt(GMSPlaceField.photos.rawValue))
        
        autocompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
        
        
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacesAutoComplete>) {
    }
    
    
    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate, ObservableObject {
        @Binding var address1 : String
        @Binding var address2 : String
        var geocoding : Geocoding
        var dMatrix : DistanceMatrix
        var parent: PlacesAutoComplete
        var placeDetail : PlaceDetail
        var oneArray : [String]
        var twoArray : [String]
        
        init(_ parent: PlacesAutoComplete, geocoding : Geocoding, dMatrix : DistanceMatrix, address1 : Binding<String>, address2 : Binding<String>, placeDetail : PlaceDetail, oneArray : [String] , twoArray : [String] ){
            self.parent = parent
            self.geocoding = geocoding
            self.dMatrix = dMatrix
            self._address1 = address1
            self._address2 = address2
            self.placeDetail = placeDetail
            self.oneArray = oneArray
            self.twoArray = twoArray
            
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
                    dMatrix.PlaceIDs[0] = place.placeID!
                    
                    placeDetail.FormattedAddress = place.formattedAddress!
                    placeDetail.Name = place.name!
                    placeDetail.PlaceID = place.placeID!
//                    placeDetail.Rating = place.rating
                    //                    placeDetail.PhoneNumber = place.phoneNumber!
                    
                    oneArray[0] = place.formattedAddress!
                    oneArray[1] = place.name!
                    oneArray[2] = place.placeID!
                    oneArray[3] = place.phoneNumber!

                    placeDetail.PlaceDetailDictionary[0] = oneArray
                    
                    
                    address1 = place.formattedAddress!
                    if dMatrix.PlaceIDs[1] != "2"{
                        dMatrix.getData2()
                        
                    }
                    
                    
                }
                if geocoding.count == false {
                    
                    geocoding.count = false
                    print("in AC below false")
                    print(geocoding.count)
                    
                    placeDetail.FormattedAddress = place.formattedAddress!
                    placeDetail.Name = place.name!
                    placeDetail.PlaceID = place.placeID!
//                    placeDetail.Rating = place.rating
                    //                    placeDetail.PhoneNumber = place.phoneNumber!
                    
                   twoArray[0] = place.formattedAddress!
                    twoArray[1] = place.name!
                    twoArray[2] = place.placeID!
                    twoArray[3] = place.phoneNumber!
                    
                    placeDetail.PlaceDetailDictionary[1] = twoArray
                    
                    
                    geocoding.placeIDThing  = place.placeID!
                    self.parent.address2 =  place.name!
                    dMatrix.PlaceIDs[1] = place.placeID!
                    
                    address2 = place.formattedAddress!
                    
                    if dMatrix.PlaceIDs[0] != "1"{
                        dMatrix.getData2()
                        
                    }
                    
                    
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
