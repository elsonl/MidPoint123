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
    @ObservedObject var nearbySearch = NearbySearch(geocoding: Geocoding(placeIDThing: "", count: true), placeDetail: PlaceDetail())
    
    init(Latitudes : [Double], Longitudes : [Double], Names : [String], PlaceIDs : [String]){
        self.Latitudes = Latitudes
        self.Longitudes = Longitudes
        self.Names = Names
        self.PlaceIDs = PlaceIDs
    }
    
    func getCoords() {
        print("woah")
        nearbySearch.getData { [self] (responses3: Response3) in
            print(responses3.results)
            let number : Int = responses3.results.count
            print("this is the count \(number)")
            for count in 0..<0{
                
                Latitudes[count] = responses3.results[count].geometry.location.lat!
                print("1 thinythingthing")
                Longitudes[count] = responses3.results[count].geometry.location.lng!
                Names[count] = responses3.results[count].name!
                print("2")
                PlaceIDs[count] = responses3.results[count].place_id!
                
                print("3")
            }
        }
    }
    
    
}
