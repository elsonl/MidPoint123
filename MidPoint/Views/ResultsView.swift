//
//  ResultsView.swift
//  MidPoint
//
//  Created by Elson Lin on 3/11/22.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var dMatrix : DistanceMatrix
    @Binding var zoom : Zoom
    var body: some View {
        
        var distance = dMatrix.responses2.rows.first?.elements.first?.distance 
        var duration = dMatrix.responses2.rows.first?.elements.first?.duration
        ZStack{
            Rectangle().foregroundColor(Color.gray).frame(width: 400, height: 225, alignment: .center).cornerRadius(35)
            ScrollView(.horizontal){
                HStack(alignment : .center){
                    ForEach(0..<10){_ in
                        
                        Text("\(String(describing:distance)) \(String(describing:duration))").frame(width: 375, height: 200, alignment: .center).background(RoundedRectangle(cornerRadius: 20).foregroundColor(.red))
                        
                      
                       
                        
                    }
                    
                }
            }.frame(width: 375, height: 225, alignment: .center)
            
        }
       
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(zoom: .constant(Zoom()))
    }
}


