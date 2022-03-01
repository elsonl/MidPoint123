//
//  Geocoding.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/23/22.
//

import Foundation
import SwiftUI
import GoogleMaps
//AIzaSyBSbbHUfKBkD3O0gQXQadLJnAuy3nQvHNM

//https://maps.googleapis.com/maps/api/geocode/json?place_id=ChIJeRpOeF67j4AR9ydy_PIzPuM&key=AIzaSyBSbbHUfKBkD3O0gQXQadLJnAuy3nQvHNM

class Geocoding : ObservableObject{

    @Published var responses = Response()
    @Binding var placeIDThing : String

    var placeId = "ChIJeRpOeF67j4AR9ydy_PIzPuM"

    init(placeIDThing: Binding<String>){
        self._placeIDThing = placeIDThing
        self.getData()
    }

    func getData(){

        print("getting data")

        guard let url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?place_id=\(placeId)&key=AIzaSyBSbbHUfKBkD3O0gQXQadLJnAuy3nQvHNM") else {

            print("error creating url")
            return

        }

        print("URL created")

        URLSession.shared.dataTask(with: url) { (data, response, erros) in
            guard let data = data else{
                print("error downloading data")
                return
            }

            print("Data downloaded")

//            guard let dataAsString = String(data: data, encoding: .utf8) else {return}
//            print(dataAsString)

            let decoder = JSONDecoder()

            if let response = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async{ [self] in
                    self.responses = response

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


