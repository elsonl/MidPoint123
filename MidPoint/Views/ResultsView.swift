//
//  ResultsView.swift
//  MidPoint
//
//  Created by Elson Lin on 3/11/22.
//

import SwiftUI
import GooglePlaces

struct ResultsView: View {
    @EnvironmentObject var dMatrix : DistanceMatrix
    @EnvironmentObject var placeDetail : PlaceDetail
    var body: some View {
        let distance = dMatrix.responses2.rows.first?.elements.first?.distance.text! ?? "error"
        let duration = dMatrix.responses2.rows.first?.elements.first?.duration.text! ?? "error"
        ZStack{
            Rectangle().foregroundColor(Color.gray).frame(width: 400, height: 225, alignment: .center).cornerRadius(35)
            ScrollView(.horizontal){
                HStack(alignment : .center){
                    
                    ForEach(0..<10){i in
                        VStack{
                            
                            Text(verbatim: "\(distance)")
                            Text(verbatim: "\(duration)")

                            
                            
                        }.frame(width: 375, height: 200, alignment: .center).background(RoundedRectangle(cornerRadius: 20).foregroundColor(.red))
   
                    }
                }
            }.frame(width: 375, height: 225, alignment: .center)
            
        }
        
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}


