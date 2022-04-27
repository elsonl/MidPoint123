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
    @EnvironmentObject var placeDetails : PlaceDetails

    @State var visible = false
    @State var visibleSlider = false
    @Binding var delegatePlaceID : String
    @Binding var showPlaceID : Bool
    @Binding var showDetail : Bool
    @Binding var cameraChange : Bool
    @Binding var toLat : Double
    @Binding var toLong : Double
    @Binding var adjustMarker : Bool 

    
    
    var body: some View {
        VStack{
            GoogleMapsView( delegatePlaceID: $delegatePlaceID, showPlaceID: $showPlaceID, showDetail: $showDetail, cameraChange: $cameraChange, toLat: $toLat, toLong: $toLong, adjustMarker: $adjustMarker).edgesIgnoringSafeArea(.all)

            if nearbySearch.responses3.results.first?.name! != nil {

                ListView(delegatePlaceID: $delegatePlaceID, showPlaceID: $showPlaceID, cameraChange: $cameraChange, toLat: $toLat, toLong: $toLong, adjustMarker: $adjustMarker).edgesIgnoringSafeArea(.all).onAppear{
                    adjustMarker = false
                }
            } else {
                Text("There is Nothing around the MidPoint :(")
            }
//            DetailInformationView(delegatePlaceID: $delegatePlaceID, showPlaceID: $showPlaceID, showDetail: $showDetail

            }
            
            //show list
               
                
                
            
//            VStack{
//
//                Spacer()
//                VStack{
//
//
//                    VStack {
//                        Toggle("", isOn: $visible)
//                            .labelsHidden()
//
//                        if visible {
//                            ResultsView()
//                        } else {
//                            Text("")
//                        }
//
//                        Toggle("", isOn: $visibleSlider)
//                            .labelsHidden()
//
//
//                        //slider
//                        if visibleSlider {
//                            VStack{
//                                Slider(value: $placeDetail.mile, in: 0...10)
//
//
//                                Text("\(placeDetail.mile, specifier: "%.2f") Mile Radius")
//
//                                Button("Confirm") {
//                                    placeDetail.miles = placeDetail.mile
//
//                                }
//                            }
//                        } else {
//                            Text("")
//                        }
//                    }
//
//                }
//
//            }
        }
    }


