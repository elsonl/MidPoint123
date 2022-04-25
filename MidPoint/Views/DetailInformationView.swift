//
//  DetailInformationView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 4/14/22.
//

import SwiftUI
import struct Kingfisher.KFImage


struct DetailInformationView: View {
    @EnvironmentObject var placesManager : PlacesManager
    @Binding var delegatePlaceID : String
    @Binding var showPlaceID : Bool
//    @State var currentIndexNumber : Int = 0
    @State var showDetail : Bool = false
    @EnvironmentObject var placeDetails : PlaceDetails
    @EnvironmentObject var nearbySearch : NearbySearch
    
    
    func getIndexNumber(CurrentPlaceID : String) -> Int{
     
        for count in placesManager.PlaceIDs.indices{
            if placesManager.PlaceIDs[count] == CurrentPlaceID {
                return count
            }

        }
        return 0
        }
    
    func getDetails(cIndexNumber : Int){
        var show : Bool = true
        placeDetails.PlaceIDs = nearbySearch.responses3.results[cIndexNumber ].place_id!
        print("\(placeDetails.PlaceIDs) placeDetailPlaceID")
      
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
    }
    
    var body: some View {
        
        
    var currentIndexNumber = getIndexNumber(CurrentPlaceID: delegatePlaceID)
        
        
        ZStack{
            Rectangle().foregroundColor(Color.blue).frame(width: 375, height: 225, alignment: .center).cornerRadius(35).opacity(0.5)
            ScrollView(.vertical){
                
                HStack(alignment : .center){
                    // space for picture
                    ZStack{
                        if showDetail {
                            let photoReference = placeDetails.responses4.result!.photos.first?.photo_reference ?? "not availible"
                            if(photoReference == "not availible"){
                                Text("No Photos Availible")
                            } else {
                                
                                KFImage(URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photo_reference=\(photoReference)&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4")).resizable().aspectRatio(contentMode: .fit)
                            }
                        } else {
                        Rectangle().padding().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                        Text("Picture here loading")
                        }
                        
                    }
                    // space for information of place
                    VStack{
                        
                        Button("Left"){
                            if currentIndexNumber == 0{
                                currentIndexNumber = 19
                                print("\(currentIndexNumber) left")
                                delegatePlaceID = placesManager.PlaceIDs[currentIndexNumber]
                                print(delegatePlaceID)
                                
                                currentIndexNumber = getIndexNumber(CurrentPlaceID: delegatePlaceID)
                                getDetails(cIndexNumber: currentIndexNumber)
                            } else {
                                currentIndexNumber -= 1
                                print("\(currentIndexNumber) left norm")
                                delegatePlaceID = placesManager.PlaceIDs[currentIndexNumber]
                                print(delegatePlaceID)
                                
                                currentIndexNumber = getIndexNumber(CurrentPlaceID: delegatePlaceID)
                                getDetails(cIndexNumber: currentIndexNumber)
                                
                            }
                        }
                        
                        Button("Right") {
                            if currentIndexNumber == 19 {
                                currentIndexNumber = 0
                                print("\(currentIndexNumber) right")
                                
                                delegatePlaceID = placesManager.PlaceIDs[currentIndexNumber]
                                print(delegatePlaceID)
                                
                                
                                currentIndexNumber = getIndexNumber(CurrentPlaceID: delegatePlaceID)
                                getDetails(cIndexNumber: currentIndexNumber)
                                
                                
                            } else {
                            currentIndexNumber += 1
                                print("\(currentIndexNumber) right norm")
                                delegatePlaceID = placesManager.PlaceIDs[currentIndexNumber]
                                print(delegatePlaceID)
                                
                                
                                currentIndexNumber = getIndexNumber(CurrentPlaceID: delegatePlaceID)
                                getDetails(cIndexNumber: currentIndexNumber)
                                
                            }
                        }

                        if showDetail{
                            
                            let   name = placeDetails.responses4.result?.name ?? "no name availible"

                            let    formattedAddress = placeDetails.responses4.result!.formatted_address ?? "no address availible"
                            let      formattedPhoneNumber = placeDetails.responses4.result!.formatted_phone_number ?? "no phone number availible"
   
                            let      openHours = placeDetails.responses4.result!.opening_hours.weekday_text
                            let      rating = placeDetails.responses4.result!.rating ?? -1

                            let  website = placeDetails.responses4.result!.website ?? "no website availible"
                            Text(verbatim : "\(name)")
                            HStack{
                            Text(verbatim : "\(formattedAddress)")
                                Button(action: {   UIPasteboard.general.string = formattedAddress
                                                                }) {
                                                            Text("Copy to clipboard").foregroundColor(.white)
                                                                        
                                                                    Image(systemName: "doc.on.doc")
                                                                }
                            }
                            HStack{
                            Text(verbatim : "\(formattedPhoneNumber)")
                                Button(action: {   UIPasteboard.general.string = formattedPhoneNumber
                                                                }) {
                                                            Text("Copy to clipboard").foregroundColor(.white)
                                                                        
                                                                    Image(systemName: "doc.on.doc")
                                                                }
                            }
                            Text(verbatim : "\(openHours[0])\n\(openHours[1])\n\(openHours[2])\n\(openHours[3])\n\(openHours[4])\n\(openHours[5])\n\(openHours[6])")
                            Text(verbatim : "\(rating)")
                            Link("\(website)", destination: (URL(string: "\(website)") ?? URL(string: "google.com"))!)
                        } else {
                            Text("Loading")
                        }
                       
                    }
                }
            }.frame(width: 375, height: 225, alignment: .center)
            
        }
   
        
    }
}
   

//                 if showPlaceID {      ForEach(placesManager.PlaceIDs, id: \.self){count in
//                            Text(count)
//                        }}
