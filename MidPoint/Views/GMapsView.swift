//
//  GMapsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/10/22.
//

import SwiftUI

struct GMapsView: View {
    
    @EnvironmentObject var dMatrix : DistanceMatrix
    @State var visible = false
    
    var body: some View {
        ZStack{
            
            GoogleMapsView().edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                VStack{
                    
                    
                    Toggle("", isOn: $visible)
                        .labelsHidden()
                    
                    if visible {
                        ResultsView()
                    } else {
                        Text("")
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
