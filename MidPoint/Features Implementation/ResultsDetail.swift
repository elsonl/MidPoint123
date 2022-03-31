//
//  ResultsDetail.swift
//  MidPoint
//
//  Created by Elson Lin on 3/12/22.
//

import Foundation
import GooglePlaces
class PlaceDetail : ObservableObject{
 
    @Published var miles : Double = 1
    @Published var mile : Double = 1
    
    let id = UUID()
}


//let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
//                                            UInt(GMSPlaceField.placeID.rawValue) |
//                                            UInt(GMSPlaceField.phoneNumber.rawValue) |
//                                            UInt(GMSPlaceField.formattedAddress.rawValue) |
//                                            UInt(GMSPlaceField.rating.rawValue) |
//                                            UInt(GMSPlaceField.openingHours.rawValue) |
//                                            UInt(GMSPlaceField.priceLevel.rawValue) |
//                                            UInt(GMSPlaceField.website.rawValue) |
//                                            UInt(GMSPlaceField.userRatingsTotal.rawValue) |
//                                            UInt(GMSPlaceField.photos.rawValue))
