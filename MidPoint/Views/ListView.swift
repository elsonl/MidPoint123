//
//  ListView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/31/22.
//
import MapKit
import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces

struct ListView: View {
    @State var listCount : Int = 0
    
    @State var showDetail : Bool = false
    @Binding var delegatePlaceID : String
    @Binding var showPlaceID : Bool
    @EnvironmentObject var nearbySearch : NearbySearch
    @EnvironmentObject var placesManager : PlacesManager
    @EnvironmentObject var placeDetails : PlaceDetails
    @Binding var cameraChange : Bool
    
    var body: some View {
        
        NavigationView{
            
            List(nearbySearch.responses3.results.indices){ counts in
                NavigationLink(destination : ResultsDetailsView(listCount : .constant(counts), showDetail: .constant(showDetail), cameraChange: $cameraChange).onAppear{
                    print("i have appeared")
                     cameraChange = true
                    print("caihoi")
                    //                var show : Bool =  true
//                    var view = GoogleMapsView(delegatePlaceID: $delegatePlaceID, showPlaceID: $showPlaceID, showDetail: $showDetail)
//                    var orange = GoogleMapsView.updateUIView(view)
//                   print(orange)
//
                    placeDetails.PlaceIDs = nearbySearch.responses3.results[counts].place_id!
                    
                    //                if show {
                    //                showDetail = false
                    //                }
                    
                    placeDetails.getData(){
                        
                        print("\(placeDetails.responses4.result!) RESULTS" )
                        print("\(placeDetails.responses4.result!.name ?? "nothing here") : name thingy")
                        var name = placeDetails.responses4.result?.name ?? "nil"
                        print("\(name) name")
                        if name != "nil"{
                            showDetail = true
                            //                        show = false
                        }
                        //                    show = true
                    }
                    
                },
                label:
                    {
                        
                        Text(verbatim: "\((counts)+1). \(nearbySearch.responses3.results[counts].name ?? "something went wrong :(") ")
                        
                        
                        
                    }
                )
                
            }.frame( height: 350, alignment: .bottom).ignoresSafeArea().navigationTitle("Results") .navigationBarTitleDisplayMode(.inline).edgesIgnoringSafeArea(.all)
            
            
        }.edgesIgnoringSafeArea(.all)}
}
