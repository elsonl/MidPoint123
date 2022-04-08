//
//  FavoritesView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/28/22.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var geocoding : Geocoding
    @EnvironmentObject var dMatrix : DistanceMatrix
    @Binding var favoritesName : String
    @Binding var favoritesAddress : String
    @State var showFavoriteSheet = false
    @Binding var favorites : [String : String]
    @Binding var address1 : String
    @Binding var address2 : String
    @Binding var favoritesOpen : Bool
    var body: some View {
        VStack{
            VStack{
                HStack{
                    
                    Image(systemName: "magnifyingglass").hidden()
                    TextField("Name...", text: $favoritesName).foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }.frame(width: 375, alignment: .trailing)
              
                HStack{
                    Image(systemName: "magnifyingglass")
                    TextField("Location...", text: $favoritesAddress,onEditingChanged: { _ in
                        geocoding.favoritesCount = true
                        if (favoritesAddress == "") {
                            
                            showFavoriteSheet = true
                        }
                    }, onCommit: {
                        showFavoriteSheet = false
                    })
                        .foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                        .sheet(isPresented : $showFavoriteSheet, onDismiss: {
                            
                            if(favoritesAddress == ""){
                                showFavoriteSheet = true
                            } else {
                                geocoding.favoritesCount = true
                                showFavoriteSheet = false
                                
                            }
                        }) { PlacesAutoComplete(geocoding: _geocoding, dMatrix: _dMatrix, address1: $address1, address2: $address2, favoritesAddress: $favoritesAddress)
                            .environmentObject(geocoding) }
                }.frame(width: 375, height: 30, alignment: .trailing).padding()
            }
            Button(action: {favorites.updateValue(favoritesAddress, forKey: favoritesName); favoritesOpen.toggle(); favorites.removeValue(forKey: ""); favoritesAddress=""; favoritesName=""}, label: {Text("Add Favorite")})
            
            
            
            
            
            
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    
}



