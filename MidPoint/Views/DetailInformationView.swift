//
//  DetailInformationView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 4/14/22.
//

import SwiftUI

struct DetailInformationView: View {
    @Binding var delegatePlaceID : String
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color.blue).frame(width: 375, height: 225, alignment: .center).cornerRadius(35).opacity(0.5)
            ScrollView(.horizontal){
                
                HStack(alignment : .center){
                    
                    // space for picture
                    ZStack{
                        Rectangle().padding().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.yellow)
                        Text("Picture here")
                        
                    }
                    
                    Rectangle().padding()
                    // space for information of place\\
                    
                    VStack{
                        Text("\(delegatePlaceID)")
                        Text("2")
                        Text("3")
                        Text("4")
                        Text("5")
                        
                    }
                }
                
                
                
            }.frame(width: 375, height: 225, alignment: .center)
            
        }
    }
}

struct DetailInformationView_Previews: PreviewProvider {
    static var previews: some View {
        DetailInformationView(delegatePlaceID: .constant("I AM CONSTANT"))
    }
}


