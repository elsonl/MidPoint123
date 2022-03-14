//
//  FavoritesView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/28/22.
//

import SwiftUI

struct FavoritesView: View {

    @State var favorites : [String: String] = ["Test" : "", "Test2": "", "Test3": "" ] //name:address
    @State private var showFavoriteSheet = false
    @State var address : String = ""
    @State var name : String = ""
    //@EnvironmentObject var geocoding : Geocoding //(for autocomplete later)
    var body: some View {
        
        ZStack{
            Rectangle().foregroundColor(Color.gray).frame(width: 400, height: 125, alignment: .center).cornerRadius(35)
        ScrollView(.horizontal){
            HStack(spacing : 15){
                Button(action: {showFavoriteSheet = true; print("sheet loaded")},
                       label: {Text("+Add")})
                    .sheet(isPresented: $showFavoriteSheet, onDismiss:{
                            favorites.updateValue(address, forKey: name)
                        showFavoriteSheet = false
                        
                    }, content:
                        {VStack{

                            Text("Loaded")
                            TextField("Name...", text: $name)
                                TextField("Location", text: $address) //get autocomplete working eventually
                        }

                    }).padding()
                    .background(Color.black)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                ForEach(favorites.keys.sorted(), id: \.self){
            Text($0).frame(width: 110, height: 100, alignment: .center).background(RoundedRectangle(cornerRadius: 20).foregroundColor(.red))
        }
            }
        }.frame(width: 360, height: 100, alignment: .center)
    }
    }
}



