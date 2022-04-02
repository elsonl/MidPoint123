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
        
        
        let name = placeDetails.responses4.result!.name!
        
        let formattedAddress = placeDetails.responses4.result!.formatted_address!
        let formattedPhoneNumber = placeDetails.responses4.result!.formatted_phone_number!
        let openNow = placeDetails.responses4.result!.opening_hours.open_now!
        let openHours = placeDetails.responses4.result!.opening_hours.weekday_text
        let rating = placeDetails.responses4.result!.rating!
        let numUserRating = placeDetails.responses4.result!.user_ratings_total!
        var website = placeDetails.responses4.result!.website!
        var priceLevel = placeDetails.responses4.result!.price_level!
        

        List(){
          
            Text(name)
            Text(formattedAddress)
            Text(formattedPhoneNumber)
            Text(openNow)
            Text(openHours)
            Text(rating)
            Text(numUserRating)
            Text(website)
            Text(priceLevel)
            

        }
    }
}

struct ResultsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailsView(listCount: .constant(0))
    }
}
