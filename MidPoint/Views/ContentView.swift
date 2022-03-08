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
    @State private var showsheet1 = false
    @State private var showsheet2 = false
    
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                
                Text(address1 + "1")
                Text(address2 + "2")
                
                
                TextField("Location 1 ...", text: $address1,onEditingChanged: { _ in
                    geocoding.count = true
                    print("1, count true")
                    if (address1 == "") {
                        showsheet1 = true
                        print("Address1 change, showsheet true")
                    }
                }, onCommit: {
                    showsheet1 = false
                    print("address1 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4))
                .sheet(isPresented : $showsheet1, onDismiss: {
                    if(address1 == ""){
                        print("address 1 empty, showsheet true")
                        showsheet1 = true
                    } else {
                        geocoding.count = true
                        
                        print(geocoding.count)
                        print("in else")
                        
                        print("showsheet1false")
                        showsheet1 = false
                        geocoding.getData()
                        
                    }
                }) { PlacesAutoComplete(geocoding: _geocoding, address1: $address1, address2: $address2)
                    .environmentObject(geocoding) }
                
   
                TextField("Location 2 ...", text: $address2,onEditingChanged: { _ in
                    geocoding.count = false
                    print("2, count false")
                    if (address2 == "") {
                        showsheet2 = true
                        print("Address2 change, showsheet true")
                    }
                }, onCommit: {
                    showsheet2 = false
                    print("address2 committed")
                }).foregroundColor(Color.black).background(Color(.systemGray4))
                .sheet(isPresented : $showsheet2, onDismiss: {
                    if(address2 == ""){
                        print("address 2 empty, showsheet true")
                        showsheet2 = true
                    } else {
                        geocoding.count = false
                        
                        print(geocoding.count)
                        print("in else")
                    
                        print("showsheet2false")
                        showsheet2 = false
                        geocoding.getData()
                        
                    }
                }) { PlacesAutoComplete(geocoding: _geocoding, address1: $address1, address2: $address2)
                    .environmentObject(geocoding) }
                

                NavigationLink("click me for Maps View", destination: GoogleMapsView().edgesIgnoringSafeArea(.all))
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(address1: "", address2: "")
    }
}
