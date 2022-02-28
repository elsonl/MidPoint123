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
    @State var placeID : String
    @State private var showsheet = false
    
    var body: some View {
        
        //var thing : String = geocoding.responses.results.first?.formatted_address! ?? "failed"
        
        //        Text(geocoding.responses.results.first?.formatted_address ?? "failed")
        
        NavigationView{
            
            
            VStack{
                
                TextField("Search ...", text: $address1,onEditingChanged: { begin in
                    if begin {
                        showsheet = true
                        print("Address1 change")
                    } else {
                       
                        print("Address1 finish")
                    }
                }, onCommit: {
                    showsheet = false
                    print("address1 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4)).sheet(isPresented : $showsheet, onDismiss: {
                    if(address1 == ""){
                        print("address 1 showsheet empty")
                        showsheet = false
                    }
                }) { PlacesAutoComplete(address1: $address1) }
                
                
                TextField("Search ...", text: $address2,onEditingChanged: { begin in
                    if begin {
                        showsheet = true
                        print("Address2 change")
                    } else {
                        
                        print("Address2 finish")
                    }
                }, onCommit: {
                    showsheet = false
                    print("address2 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4)).sheet(isPresented : $showsheet, onDismiss: {
                    if(address2 == ""){
                        print("address 2 showsheet empty")
                        showsheet = false
                
                    }
                }) { PlacesAutoComplete2(address2: $address2) }
                
         
                
                
                NavigationLink("click me for Maps View", destination: GoogleMapsView().edgesIgnoringSafeArea(.all))
                
            }
        }
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(address1: "", address2: "", placeID: "")
    }
}
