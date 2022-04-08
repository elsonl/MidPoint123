//
//  NearbySearch.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/30/22.
//

import MapKit
import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
//https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4&location=35.2251519,-80.8393911&radius=5000
class NearbySearch : ObservableObject{
    @ObservedObject var placeDetail = PlaceDetail()
    
    @Published var responses3 = Response3()
    @Published var coordinatesNS : (Double?, Double?, Double?, Double?) = (0,0,0.5,0.5)
    func getData(callback: @escaping () -> Void){
        
        let midLat = (coordinatesNS.0! + coordinatesNS.2!)/2
        let midLong = (coordinatesNS.1! + coordinatesNS.3!)/2
        var meters : Double = 1609.34
        print("getting data")
        
        meters = 1609.34 * placeDetail.miles
        
        print("mid lat : \(midLat)")
        print("mid long : \(midLong)")
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4&location=\(midLat),\(midLong)&radius=50000") else {
            
            print("error creating url")
            return
            
        }
        
        print("URL created")
        
        URLSession.shared.dataTask(with: url) { (data, response3, erros) in
            guard let data = data else{
                print("error downloading data")
                return
            }
            
            print("Data downloaded")
            
            
            let decoder = JSONDecoder()
            
            if let response3 = try? decoder.decode(Response3.self, from: data) {
                DispatchQueue.main.async{
                    self.responses3 = response3
                    print(self.responses3.results)
                    callback()
                    
                }
                
            }else {
                print("error with decoder")
            }
        }.resume()
    }
    
}

//Structs for our JSON
struct Response3: Codable{
    var results : [result2] = [result2]()
    
}

struct result2 : Codable{
    var name : String?
    var geometry : Geometry
    var place_id : String?
}
//
struct Geometry: Codable{
    var location : locations2
}

struct locations2 : Codable{
    var lat : Double?
    var lng : Double?
}

extension result2: Identifiable{
    var id: String {return name!}
}


