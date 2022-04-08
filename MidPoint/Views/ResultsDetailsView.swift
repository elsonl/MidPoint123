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
        
        
//        Button("21"){
//            placeDetails.PlaceIDs = nearbySearch.responses3.results[listCount].place_id!
//            placeDetails.getData(){
//                print(placeDetails.responses4.result)
//                print("hi")
                
             var   name = placeDetails.responses4.result!.name

        var    formattedAddress = placeDetails.responses4.result!.formatted_address
        var      formattedPhoneNumber = placeDetails.responses4.result!.formatted_phone_number
        var      openNow = placeDetails.responses4.result!.opening_hours.open_now
        var      openHours = placeDetails.responses4.result!.opening_hours.weekday_text
        var      rating = placeDetails.responses4.result!.rating
        var         numUserRating = placeDetails.responses4.result!.user_ratings_total
        var         website = placeDetails.responses4.result!.website
            
                            
                
//            }
//        }
//
       
        

        List(){
          
            Text(verbatim : "\(name)")
            Text(verbatim : "\(formattedAddress)")
            Text(verbatim : "\(formattedPhoneNumber)")
//            Text(openNow)
            Text(verbatim : "\(openHours)")
            Text(verbatim : "\(rating)")
            Text(verbatim : "\(numUserRating)")
            Text(verbatim : "\(website)")
            

        }

      
    }
}

struct ResultsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailsView(listCount: .constant(0))
    }
}
