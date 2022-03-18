//
//  FavoritesView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/28/22.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var favoritesName : String
    @Binding var favoritesAddress : String
    @Binding var favorites : [String : String]
    var body: some View {
        TextField("Name...", text: $favoritesName).foregroundColor(.black)
        TextField("Location", text: $favoritesAddress).foregroundColor(.black)
            
            
            
        
        
    }
    
    
}




