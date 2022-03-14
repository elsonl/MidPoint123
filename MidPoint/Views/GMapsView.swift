//
//  GMapsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/10/22.
//

import SwiftUI

struct GMapsView: View {
    
    @EnvironmentObject var dMatrix : DistanceMatrix
    @Binding var zoom : Zoom
        var body: some View {
            ZStack{
               
                GoogleMapsView(zoom: .constant(Zoom())).edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    ResultsView(zoom: .constant(Zoom()))
                    
                    Button("+") {
                        print("button1")
                        zoom.currentZoom += 1
                    }
                    Button("-") {
                        print("button2")
                        zoom.currentZoom -= 1
                    }
                    
                    Slider(value: $zoom.currentZoom, in: 1...10)
                    
//                    Slider(value: $zoom.currentZoom, in: 1...10)
//                    Text("Slider Above")
                    
                  
                   
                }
             
            }
    }
    
    struct GMapsView_Previews: PreviewProvider {
        static var previews: some View {
            GMapsView( zoom: .constant(Zoom()))
        }
    }
}
