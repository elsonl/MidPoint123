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
    
    var body: some View {
        
        var thing : String = geocoding.responses.results.first?.formatted_address! ?? "failed"
        
        Text(thing)
    
        NavigationView{

            
            NavigationLink("click me", destination: GoogleMapsView())


        }.onAppear(perform: {self.geocoding.getData()})
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
