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
    
    var body: some View {
        
        //var thing : String = geocoding.responses.results.first?.formatted_address! ?? "failed"
        
        //        Text(geocoding.responses.results.first?.formatted_address ?? "failed")
        
        NavigationView{
            
            
            VStack{
                Text(address1 + "1")
                Text(address2 + "2")
                TextField("Search ...", text: $address1,onEditingChanged: { _ in
                    if (address1 == "") {
                        showsheet = true
                        print("Address1 change")
                    }
                    
                }, onCommit: {
                    showsheet = false
                    print("address1 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4)).sheet(isPresented : $showsheet, onDismiss: {
                    if(address1 == ""){
                        print("address 1 empty")
                        showsheet = true
                    } else {
                        print("showsheet1 false")
                        showsheet = false
                    }
                }) { PlacesAutoComplete(address1: $address1, address2: $address2, placeIDThing: "") }
                
                
                
                
                NavigationLink("click me for Maps View", destination: GoogleMapsView().edgesIgnoringSafeArea(.all))
                
                
                HStack{
                    TextField("Search ...", text: $address2,onEditingChanged: { begin2 in
                        if (address2 == "") {
                            showsheet = true
                            print("Address2 change")
                        }
                    }, onCommit: {
                        showsheet = false
                        print("address2 committed")
                    }).foregroundColor(Color.black).background(Color(.systemGray4)).sheet(isPresented : $showsheet, onDismiss: {
                        if(address2 == ""){
                            print("address 2 empty")
                            showsheet = true
                        } else {
                            print("showsheet2 false")
                            showsheet = false
                        }
                    }) { PlacesAutoComplete(address1: $address1, address2: $address2, placeIDThing: "") }
                    
                    
                    
                }
                
                
            }
            
        }
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(address1: "", address2: "")
    }
}
