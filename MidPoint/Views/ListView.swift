//
//  ListView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/31/22.
//

import SwiftUI

struct ListView: View {
    @State var listCount : Int = 0
    @EnvironmentObject var nearbySearch : NearbySearch
    @EnvironmentObject var placesManager : PlacesManager
    @EnvironmentObject var placeDetails : PlaceDetails
    
    
    var body: some View {
        
        
        List(nearbySearch.responses3.results.indices){ counts in
            NavigationLink(destination : ResultsDetailsView(listCount : .constant(counts)).onAppear{
                print("i have appeared")
                placeDetails.PlaceIDs = nearbySearch.responses3.results[counts].place_id!
                placeDetails.getData(){
                    print(placeDetails.responses4.result!)
                }
            },
label: {
    
    
    Button(action : {
        print("I AM A BUTTOn")
        
       
    }, label: {
        Text(verbatim: "\((counts)+1). \(nearbySearch.responses3.results[counts].name ?? "something went wrong :(") ")
    }).navigationViewStyle(StackNavigationViewStyle())
       

  
    
})
                                                    
        }.navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
