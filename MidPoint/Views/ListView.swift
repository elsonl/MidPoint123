//
//  ListView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/31/22.
//

import SwiftUI

struct ListView: View {
    @State var listCount : Int = 0
    @State var showDetail : Bool = false
    @EnvironmentObject var nearbySearch : NearbySearch
    @EnvironmentObject var placesManager : PlacesManager
    @EnvironmentObject var placeDetails : PlaceDetails
    
    
    var body: some View {
        
        
        
        List(nearbySearch.responses3.results.indices){ counts in
            NavigationLink(destination : ResultsDetailsView(listCount : .constant(counts), showDetail: .constant(showDetail)).onAppear{
                print("i have appeared")
            
                var show : Bool = true
                
                placeDetails.PlaceIDs = nearbySearch.responses3.results[counts].place_id!
              
                if show {
                showDetail = false
                }
                
                placeDetails.getData(){
                    
                    print("\(placeDetails.responses4.result!) RESULTS" )
                    print("\(placeDetails.responses4.result!.name ?? "nothing here") : name thingy")
                    var name = placeDetails.responses4.result?.name ?? "nil"
                    print("\(name) name")
                    if name != "nil"{
                        showDetail = true
                        show = false
                    }
                    show = true
                }
            
            },
            label: {
                
     
                
                
                    Text(verbatim: "\((counts)+1). \(nearbySearch.responses3.results[counts].name ?? "something went wrong :(") ")
                .navigationViewStyle(StackNavigationViewStyle())
                
                
                
                
            })
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
        
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
