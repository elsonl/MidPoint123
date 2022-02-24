//
//  Geocoding.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/23/22.
//

import Foundation
import SwiftUI
import GoogleMaps
//AIzaSyAy5J3IPzP2kRbVtWF9ykptla8vV1_o4Pc

//https://maps.googleapis.com/maps/api/geocode/json?place_id=ChIJeRpOeF67j4AR9ydy_PIzPuM&key=AIzaSyAy5J3IPzP2kRbVtWF9ykptla8vV1_o4Pc

class Geocoding : ObservableObject{
    
    @Published var responses = Response()
    var placeID = "ChIJeRpOeF67j4AR9ydy_PIzPuM"
    
    func getData(){
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?place_id=\(placeID)&key=AIzaSyAy5J3IPzP2kRbVtWF9ykptla8vV1_o4Pc") else {return}
        

        print("elson")
        
        URLSession.shared.dataTask(with: url) { (data, response, erros) in
            guard let data = data else{
                print("error with data")
                return
            }
            
           
            let decoder = JSONDecoder()
            
            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async{ [self] in
                    self.responses = response
                    
                    
                    print(self.responses.results)
                }
                
            }else {
                print("error with decoder")
            }
        }.resume()
    }
}

//Structs for our JSON
struct Response: Codable{
    var results : [result] = [result]()
    
}

struct result: Codable{
    var formatted_address : String?
    var geometry : geometryItem
}

struct geometryItem: Codable{
    var location : locations
}

struct locations: Codable{
    var lat : Double?
    var lng : Double?
}
extension result: Identifiable{
    var id: String {return formatted_address!}
}


