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
    @State var visible = false
    @State var visibleSlider = false
    
    var body: some View {
        ZStack{
            
            GoogleMapsView().edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                VStack{
                    
                    
                   VStack {
                        Toggle("", isOn: $visible)
                            .labelsHidden()
                        
                        if visible {
                            ResultsView()
                        } else {
                            Text("")
                        }
                        
                        Toggle("", isOn: $visibleSlider)
                            .labelsHidden()
                        
                        if visibleSlider {
                            VStack{
                                Slider(value: $placeDetail.mile, in: 0...10)
                                
                                
                                Text("\(placeDetail.mile, specifier: "%.2f") Mile Radius")
                                
                                Button("Confirm") {
                                    placeDetail.miles = placeDetail.mile

                                }
                            }
                        } else {
                            Text("")
                        }
                    }

                }
                
            }
        }
    }
    
    struct GMapsView_Previews: PreviewProvider {
        static var previews: some View {
            GMapsView()
        }
    }
}
