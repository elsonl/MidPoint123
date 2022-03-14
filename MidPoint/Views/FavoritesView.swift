//
//  FavoritesView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/28/22.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var address1 : String
    @State var favorites : [String] = [""] //make this a binding later
    var body: some View {
        
        ZStack{
            Rectangle().foregroundColor(Color.gray).frame(width: 400, height: 125, alignment: .center).cornerRadius(35)
        ScrollView(.horizontal){
            HStack(spacing : 15){
        ForEach(0..<10){
            Text("Item \($0)").frame(width: 110, height: 100, alignment: .center).background(RoundedRectangle(cornerRadius: 20).foregroundColor(.red))
        }
            }
        }.frame(width: 360, height: 100, alignment: .center)
    }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
