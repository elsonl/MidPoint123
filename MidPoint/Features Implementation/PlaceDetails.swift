//
//  PlaceDetails.swift
//  MidPoint
//
//  Created by Elson Lin on 3/31/22.
//



import MapKit
import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import Foundation
//https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number%2Cformatted_address%2Cwebsite%2Copening_hours%2Cprice_level%2Cuser_ratings_total%2Cphoto%2Creview&place_id=ChIJXwbcTpvAxokRpQBerYSgPqs&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4
class PlaceDetails : ObservableObject{
   @Published var  responses4 = Response4()
    @ObservedObject var placesManager = PlacesManager(Latitudes: [], Longitudes: [], Names: [], PlaceIDs: [], nearbySearch: NearbySearch())
    @Published var PlaceIDs : [String]
    @Published var count : Int = 0
    init(PlaceIDs : [String]){
        self.PlaceIDs = PlaceIDs
    }
    func getData(callback: @escaping () -> Void){

        
        var pID = "\(PlaceIDs[count])"
      print(pID)
        print("getting data")
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number%2Cformatted_address%2Cwebsite%2Copening_hours%2Cprice_level%2Cuser_ratings_total%2Cphoto%2Creview&place_id=\(pID)&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4") else {

            print("error creating url")
            return

        }

        print("URL created")

        URLSession.shared.dataTask(with: url) { (data, response4, erros) in
            guard let data = data else{
                print("error downloading data")
                return
            }

            print("Data downloaded")


            let decoder = JSONDecoder()

            if let response4 = try? decoder.decode(Response4.self, from: data) {
                DispatchQueue.main.async{
                    self.responses4 = response4
                    print(response4.result!)
                    callback()
                }

            }else {
                print("error with decoder")
            }
        }.resume()
    }
}

//Structs for our JSON
struct Response4: Codable{
    var result : resultItem?

}


struct resultItem: Codable{
    var formatted_address : String?
    var formatted_phone_number : String?
    var name : String?
    var opening_hours : openingHoursItem
//    var photos : [photosItem]
    var rating : Double?
//    var reviews : [reviewItems]
    var user_ratings_total : Int?
    var website : String?
    var price_level : Int?
}

struct openingHoursItem: Codable{
    var open_now : Bool?
    var weekday_text : [String]

}

//struct photosItem : Codable{
//
//}

//    struct reviewItem : Codable {
//
//    }

extension resultItem : Identifiable{
    var id : String {return formatted_address!}
}
