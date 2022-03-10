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
        VStack{
            TextField("Address", text: $address1)
            Button("Add Favorite", action: {favorites.append(address1)})
        }
        
        
        
        
        
    }
}
