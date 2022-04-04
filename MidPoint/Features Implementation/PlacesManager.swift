//
//  PlacesManager.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/30/22.
//

import Foundation
import GooglePlaces
import SwiftUI


class PlacesManager: ObservableObject {

    @Published var Latitudes : [Double]
    @Published var Longitudes : [Double]
    @Published var Names : [String]
    @Published var PlaceIDs : [String]
    var nearbySearch : NearbySearch
    
    init(Latitudes : [Double], Longitudes : [Double], Names : [String], PlaceIDs : [String], nearbySearch : NearbySearch){
        self.Latitudes = Latitudes
        self.Longitudes = Longitudes
        self.Names = Names
        self.PlaceIDs = PlaceIDs
        self.nearbySearch = nearbySearch
    }
    
    func getCoords() {

        let number : Int = nearbySearch.responses3.results.count
        print("this is the count \(number)")
        for count in 0..<number{
            
            Latitudes.append(nearbySearch.responses3.results[count].geometry.location.lat!)
            Longitudes.append(nearbySearch.responses3.results[count].geometry.location.lng!)
            Names.append(nearbySearch.responses3.results[count].name!)
            PlaceIDs.append(nearbySearch.responses3.results[count].place_id!)
        }
    }
    
    
}
