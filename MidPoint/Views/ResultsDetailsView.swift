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
    
    func returnPlaceID(var PlaceID : String) -> String{
        var PlaceIDs : String = ""
        placeDetails.PlaceIDs = nearbySearch.responses3.results[listCount].place_id!
        placeDetails.getData(){
            print(placeDetails.responses4.result)
            print("hi")
             PlaceIDs = placeDetails.PlaceIDs
            
        }
      
        return PlaceIDs
       
    }
    var body: some View {
        
//        var PlaceID  : String = returnPlaceID(var: "")
        
        var name : String = ""
        
        var formattedAddress : String = ""
        var formattedPhoneNumber  : String = ""
        var openNow : Bool = true
        var openHours : [String]  = [""]
        var rating : Double = -1.0
        var numUserRating : Int = -1
        var website : String = ""
        var priceLevel : Int = -1
        
        Button("21"){
            placeDetails.PlaceIDs = nearbySearch.responses3.results[listCount].place_id!
            placeDetails.getData(){
                print(placeDetails.responses4.result)
                print("hi")
                
                 name = placeDetails.responses4.result!.name!
                
                 formattedAddress = placeDetails.responses4.result!.formatted_address!
                 formattedPhoneNumber = placeDetails.responses4.result!.formatted_phone_number!
                 openNow = placeDetails.responses4.result!.opening_hours.open_now!
                 openHours = placeDetails.responses4.result!.opening_hours.weekday_text
                 rating = placeDetails.responses4.result!.rating!
                 numUserRating = placeDetails.responses4.result!.user_ratings_total!
                 website = placeDetails.responses4.result!.website!
                 priceLevel = placeDetails.responses4.result!.price_level! ?? 0
                            
                
            }
        }
        
       
        

        List(){
          
            Text(verbatim : "\(name)")
            Text(verbatim : "\(formattedAddress)")
            Text(verbatim : "\(formattedPhoneNumber)")
//            Text(openNow)
            Text(verbatim : "\(openHours)")
            Text(verbatim : "\(rating)")
            Text(verbatim : "\(numUserRating)")
            Text(verbatim : "\(website)")
            Text(verbatim : "\(priceLevel)")
            

        }

      
    }
}

struct ResultsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailsView(listCount: .constant(0))
    }
}
