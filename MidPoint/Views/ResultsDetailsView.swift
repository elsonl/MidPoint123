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
        let name = nearbySearch.responses3.results[listCount].name!
        let placeID = nearbySearch.responses3.results[listCount].place_id!
        let lat = nearbySearch.responses3.results[listCount].geometry.location.lat!

        let long = nearbySearch.responses3.results[listCount].geometry.location.lng!

        List(){
          
            Text(name)
            Text(placeID)
            Text("\(lat)")
            Text("\(long)")
        }
    }
}

struct ResultsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailsView(listCount: .constant(0))
    }
}
