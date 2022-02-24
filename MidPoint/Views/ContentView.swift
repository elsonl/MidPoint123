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
    @StateObject var geocoding = Geocoding()
    
    var body: some View {
        
        
        Text("hello")
       
            .padding()
        GoogleMapsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(geocoding: Geocoding())
    }
}
