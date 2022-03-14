//
//  Geocoding.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/23/22.
//

import Foundation
import SwiftUI
import GoogleMaps
//AIzaSyDDpQWqq6MbFXIhYhgbG3MILxZjx66z5SU

//https://maps.googleapis.com/maps/api/distancematrix/json?destinations=New%20York%20City%2C%20NY&origins=Washington%2C%20DC&units=imperial&key=AIzaSyDDpQWqq6MbFXIhYhgbG3MILxZjx66z5SU

class DistanceMatrix : ObservableObject{
    
 
    @Published var responses2 = Response2()
    @Published var PlaceIDs : [String] = ["1","2"]
    
   
    func getData2(){
     
        print("getting data")
        print("PLACE IF 1 AND 2 DISTANCE MATRIX")
        print(PlaceIDs)
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/distancematrix/json?destinations=place_id:\(PlaceIDs[0])&origins=place_id:\(PlaceIDs[1])&units=imperial&key=AIzaSyDDpQWqq6MbFXIhYhgbG3MILxZjx66z5SU") else {
            
            print("error creating url")
            return
            
        }
        
        print("URL created")
        
        URLSession.shared.dataTask(with: url) { (data, response2, erros) in
            guard let data = data else{
                print("error downloading data")
                return
            }
            
            print("Data downloaded")
            
            
            let decoder = JSONDecoder()
            
            if let response2 = try? decoder.decode(Response2.self, from: data) {
                DispatchQueue.main.async{ [self] in
                    self.responses2 = response2
                    print(responses2.rows.first?.elements.first?.distance)
                    print(responses2.rows.first?.elements.first?.duration)
                }
                
            }else {
                print("error with decoder")
            }
        }.resume()
    }
    
}

//Structs for our JSON
struct Response2 : Codable{
    var rows : [row] = [row]()
}

struct row: Codable{
    var elements : [element] = [element]()
}

struct element : Codable{
    var distance : distanceItem
    var duration : durationItem
}

struct distanceItem: Codable{
    var text : String?
    
}

struct durationItem: Codable{
    var text : String?
}

extension distanceItem: Identifiable{
    var id: String {return text!}
}
extension durationItem: Identifiable{
    var id: String {return text!}
}

