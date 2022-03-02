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
    @State var address1 : String
    @State var address2: String
    @State private var showsheet = false
//    @State var count : Bool = true
//    @State var placeIDs : [String] = ["",""]
//    @Binding var placeIDThing : String


    
    
    
    var body: some View {
        
        //var thing : String = geocoding.responses.results.first?.formatted_address! ?? "failed"
        
        //        Text(geocoding.responses.results.first?.formatted_address ?? "failed")
        
        NavigationView{
            
            VStack{
                
                Text(address1 + "1")
                Text(address2 + "2")
                
                
                TextField("Search ...", text: $address1,onEditingChanged: { _ in
                    geocoding.count = true
                    print("1, count true")
                    if (address1 == "") {
                        showsheet = true
                        print("Address1 change, showsheet true")
                    }
                    
                }, onCommit: {
                    showsheet = false
                    print("address1 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4)).sheet(isPresented : $showsheet, onDismiss: {
                    if(address1 == ""){
                        print("address 1 empty, showsheet still true")
                        showsheet = true
                    } else {
                        print("showsheet1 false")
                        showsheet = false
                        print(geocoding.placeIDThing + "PlaceIDTHING - ONE")
                        geocoding.placeIDs[0] = geocoding.placeIDThing
                        geocoding.getData()
                    }
                }) { PlacesAutoComplete(address1: $address1, address2: $address2) }
                
                
                
                TextField("Search ...", text: $address2,onEditingChanged: { _ in
                    geocoding.count = false
                    print("2, count false")
                    if (address2 == "") {
                        showsheet = true
                        print("Address2 change, showsheet true")
                    }
                }, onCommit: {
                    showsheet = false
                    print("address2 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4)).sheet(isPresented : $showsheet, onDismiss: {
                    if(address2 == ""){
                        print("address 2 empty, showsheet true")
                        showsheet = true
                    } else {
                        print("showsheet2 false")
                        showsheet = false
                        print(geocoding.placeIDThing + "PLACEIDTHING - TWO")
                        geocoding.placeIDs[1] = geocoding.placeIDThing
                        geocoding.getData()
                        
                     
                    }
                }) { PlacesAutoComplete(address1: $address1, address2: $address2) }
                
                
                
                
                NavigationLink("click me for Maps View", destination: GoogleMapsView().edgesIgnoringSafeArea(.all))
                
                
                
                
            }
            
        }.environmentObject(Geocoding(placeIDThing: "", placeIDs: ["",""], count: true))
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(address1: "", address2: "")
    }
}
