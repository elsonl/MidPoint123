//
//  ResultsDetailsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/30/22.
//

import SwiftUI

struct ResultsDetailsView: View {
    @EnvironmentObject var nearbySearch : NearbySearch
    @Binding var listCount : Int
    @Binding var showDetail : Bool
    @EnvironmentObject var placeDetails : PlaceDetails

    var body: some View {
        
//        var PlaceID  : String = returnPlaceID(var: "")
        
//        var name : String = ""
//
//        var formattedAddress : String = ""
//        var formattedPhoneNumber  : String = ""
//        var openNow : Bool = true
//        var openHours : [String]  = [""]
//        var rating : Double = -1.0
//        var numUserRating : Int = -1
//        var website : String = ""
        
        if showDetail{
            let   name = placeDetails.responses4.result?.name!

            let    formattedAddress = placeDetails.responses4.result!.formatted_address
            let      formattedPhoneNumber = placeDetails.responses4.result!.formatted_phone_number
         //   let      openNow = placeDetails.responses4.result!.opening_hours.open_now
            let      openHours = placeDetails.responses4.result!.opening_hours.weekday_text
            let      rating = placeDetails.responses4.result!.rating
            let         numUserRating = placeDetails.responses4.result!.user_ratings_total
            let         website = placeDetails.responses4.result!.website
            
            
            let photoHeight =  placeDetails.responses4.result!.photos.first?.height
            let photoWidth = placeDetails.responses4.result!.photos.first?.width
            let photoHtmlAttribution = placeDetails.responses4.result!.photos.first?.html_attributions
            let photoReference = placeDetails.responses4.result!.photos.first?.photo_reference

        List(){
          
            Text(verbatim : "\(name!)")
            Text(verbatim : "\(formattedAddress!)")
            Text(verbatim : "\(formattedPhoneNumber!)")
//            Text(openNow)
            Text(verbatim : "\(openHours[0])\n\(openHours[1])\n\(openHours[2])\n\(openHours[3])\n\(openHours[4])\n\(openHours[5])\n\(openHours[6])")
           

            Text(verbatim : "\(rating!)")
            Text(verbatim : "\(numUserRating!)")
            Text(verbatim : "\(website!)")
            Text(verbatim : "\(photoHeight!) Height \n \(photoWidth!) Width")
            Text(verbatim : "\(photoHtmlAttribution!) HTML Attribution")
            Text(verbatim : "\(photoReference!) Photo Reference")
            
            
 //             Doesnt work :(
//            Link("Link to Website", destination: URL(string: "website!")!)
            

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("does this work")
//        .toolbar{
//            Button(action:{
//                showDetail = false
//                print(showDetail)
//
//            }, label: {
//                NavigationLink(destination : GMapsView()){
//
//                    Text("back")
//                }
//            })
//        }
        } else {
            Text("Loading...")
                .navigationViewStyle(StackNavigationViewStyle())
                .navigationBarTitle("does this work1")
//                .toolbar{
//                    Button(action:{
//                        showDetail = false
//                        print(showDetail)
//
//                    }, label: {
//                        NavigationLink(destination : GMapsView()){
//
//                            Text("back")
//                        }
//                    })
//                }
        }

     
    }
}

struct ResultsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailsView(listCount: .constant(0), showDetail: .constant(false))
    }
}
