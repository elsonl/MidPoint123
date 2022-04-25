//
//  GMapsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/10/22.
//

import SwiftUI

struct GMapsView: View {
    
    @EnvironmentObject var dMatrix : DistanceMatrix
    @EnvironmentObject var placeDetail : PlaceDetail
    @EnvironmentObject var nearbySearch : NearbySearch
    @EnvironmentObject var placesManager : PlacesManager

    @State var visible = false
    @State var visibleSlider = false
    @Binding var delegatePlaceID : String
    @Binding var showPlaceID : Bool
    
    
    
    var body: some View {
        ZStack{
            GoogleMapsView( delegatePlaceID: $delegatePlaceID, showPlaceID: $showPlaceID).edgesIgnoringSafeArea(.all)
                
            VStack(alignment: .trailing){
                Spacer()
                DetailInformationView(delegatePlaceID: $delegatePlaceID, showPlaceID: $showPlaceID)
                
            }
            
            //show list
//                if nearbySearch.responses3.results.first?.name! != nil {
//
//                    ListView()
//
//                } else {
//                    Text("There is Nothing around the MidPoint :(")
//                }
                
                
            
//            VStack{
//
//                Spacer()
//                VStack{
//
//
////                    VStack {
////                        Toggle("", isOn: $visible)
////                            .labelsHidden()
////
////                        if visible {
////                            ResultsView()
////                        } else {
////                            Text("")
////                        }
////
////                        Toggle("", isOn: $visibleSlider)
////                            .labelsHidden()
////
////
////                        //slider
//////                        if visibleSlider {
//////                            VStack{
//////                                Slider(value: $placeDetail.mile, in: 0...10)
//////
//////
//////                                Text("\(placeDetail.mile, specifier: "%.2f") Mile Radius")
//////
//////                                Button("Confirm") {
//////                                    placeDetail.miles = placeDetail.mile
//////
//////                                }
//////                            }
//////                        } else {
//////                            Text("")
//////                        }
////                    }
//
//                }
//
//            }
        }
    }

}
