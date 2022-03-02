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
//    @EnvironmentObject var geocoding : Geocoding
    @State var address1 : String
    @State var address2: String
    @State private var showsheet = false
    @State var count : Bool = true
    @State var placeIDs : [String] = ["",""]
    @Binding var placeIDThing : String
    
    var body: some View {
        
        //var thing : String = geocoding.responses.results.first?.formatted_address! ?? "failed"
        
        //        Text(geocoding.responses.results.first?.formatted_address ?? "failed")
        
        NavigationView{
            
            VStack{
                
                Text(address1 + "1")
                Text(address2 + "2")
                
                
                TextField("Search ...", text: $address1,onEditingChanged: { _ in
                    count = true
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
                        placeIDs[0] = placeIDThing
                        print("PLACE ID 1 ABOVE")
                    }
                }) { PlacesAutoComplete(address1: $address1, address2: $address2, count: $count, placeIDThing: "") }
                
                
                
                TextField("Search ...", text: $address2,onEditingChanged: { _ in
                    count = false
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
                        placeIDs[1] = placeIDThing
                        print("PLACE ID 2 ABOVE")
                    }
                }) { PlacesAutoComplete(address1: $address1, address2: $address2, count: $count, placeIDThing: "") }
                
                
                
                
                NavigationLink("click me for Maps View", destination: GoogleMapsView(count: $count).edgesIgnoringSafeArea(.all))
                
                
                
                
            }
            
        }
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(address1: "", address2: "", placeIDThing: Binding.constant(""))
    }
}
