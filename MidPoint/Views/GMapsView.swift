//
//  GMapsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/10/22.
//

import SwiftUI

struct GMapsView: View {
    
    @StateObject var dMatrix = DistanceMatrix()
        var body: some View {
            ZStack{
            GoogleMapsView().edgesIgnoringSafeArea(.all)
            
             
            }
    }
    
    struct GMapsView_Previews: PreviewProvider {
        static var previews: some View {
            GMapsView()
        }
    }
}
