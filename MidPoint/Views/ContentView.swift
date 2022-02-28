//
//  ContentView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/17/22.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct ContentView: View {
    @EnvironmentObject var geocoding : Geocoding
    @State var place1 : String
    @State var place2 : String
    @State var placeID : String
    var body: some View {
        
        //var thing : String = geocoding.responses.results.first?.formatted_address! ?? "failed"
        
        //        Text(geocoding.responses.results.first?.formatted_address ?? "failed")
        
        NavigationView{
            
            
            VStack{
                
                TextField("Search ...", text: $place1).foregroundColor(Color.black).background(Color(.systemGray4))
                TextField("Search ...", text: $place2).foregroundColor(Color.black).background(Color(.systemGray4))
                
                
                
                NavigationLink("click me for Maps View", destination: GoogleMapsView()).edgesIgnoringSafeArea(.top)
                
            }
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(place1: "", place2: "", placeID: "")
    }
}
