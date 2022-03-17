//
//  ContentView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/17/22.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct ContentView: View {
    @EnvironmentObject var geocoding : Geocoding
    @EnvironmentObject var dMatrix : DistanceMatrix
    @State var address1 : String
    @State var address2: String
    @State private var showsheet1 = false
    @State private var showsheet2 = false
    @State var favorites : [String: String] = ["Test" : "", "Test2": "", "Test3": "" ] //name:address
    @State var favoritesName : String = ""
    @State var favoritesAddress : String = ""
    @State private var showFavoriteSheet = false
    @Binding var zoom : Zoom
    
    var body: some View {
        
        
        NavigationView{
            ZStack{
                Color.blue
                VStack{
                    Text("Enter Locations Below")
                    
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        TextField("Location 1 ...", text: $address1,onEditingChanged: { _ in
                            geocoding.count = true
                            print("1, count true")
                            if (address1 == "") {
                                showsheet1 = true
                                print("Address1 change, showsheet true")
                            }
                        }, onCommit: {
                            showsheet1 = false
                            print("address1 committed")
                        }).foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                        .sheet(isPresented : $showsheet1, onDismiss: {
                            if(address1 == ""){
                                print("address 1 empty, showsheet true")
                                showsheet1 = true
                            } else {
                                geocoding.count = true
                                
                                print(geocoding.count)
                                print("in else")
                                
                                print("showsheet1false")
                                showsheet1 = false
                                geocoding.getData()
                                
                            }
                        }) { PlacesAutoComplete(geocoding: _geocoding, dMatrix: _dMatrix, address1: $address1, address2: $address2)
                            .environmentObject(geocoding) }
                    }.frame(width: 375, alignment: .trailing)
                    
                    Spacer().frame(height: 25)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Location 2 ...", text: $address2,onEditingChanged: { _ in
                            geocoding.count = false
                            print("2, count false")
                            if (address2 == "") {
                                showsheet2 = true
                                print("Address2 change, showsheet true")
                            }
                        }, onCommit: {
                            showsheet2 = false
                            print("address2 committed")
                        }).foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                        .sheet(isPresented : $showsheet2, onDismiss: {
                            if(address2 == ""){
                                print("address 2 empty, showsheet true")
                                showsheet2 = true
                            } else {
                                geocoding.count = false
                                
                                print(geocoding.count)
                                print("in else")
                                
                                print("showsheet2false")
                                showsheet2 = false
                                geocoding.getData()
                                
                                
                            }
                        }) { PlacesAutoComplete(geocoding: _geocoding, address1: $address1, address2: $address2)
                            .environmentObject(geocoding) }}.frame(width: 375, alignment: .trailing)
                    
                    Spacer().frame(height: 15)
                    
                    Button(action : {
                        print("button thingyyhing")
                        dMatrix.getData2() 
                    }, label: {
                        NavigationLink(destination : GMapsView( zoom: .constant(Zoom()))){
                            
                            Text("Search")
                            
                        }
                    }).padding().background(Color.black).clipShape(Capsule()).foregroundColor(.white)
                    
                    Spacer().frame(height: 25)
                    
                    ZStack{
                        Rectangle().foregroundColor(Color.gray).frame(width: 400, height: 125, alignment: .center).cornerRadius(35)
                        ScrollView(.horizontal){
                            HStack(spacing : 15){
                                Button(action: {}, label: {
                                    
                                    Text("+Add")
                                    NavigationView{
                                        NavigationLink(destination: FavoritesView(favoritesName: $favoritesName, favoritesAddress: $favoritesAddress, favorites: $favorites)){
                                            
                                        }
                                        .onDisappear(perform: {favorites.updateValue($favoritesAddress.wrappedValue, forKey: $favoritesName.wrappedValue)})
                                    }.navigationViewStyle(StackNavigationViewStyle())
                                    
                                    
                                })
                                .background(Color.black)
                                .clipShape(Capsule())
                                .foregroundColor(.white)
                                ForEach(favorites.keys.sorted(), id: \.self){
                                    Text($0).frame(width: 110, height: 100, alignment: .center).background(RoundedRectangle(cornerRadius: 20).foregroundColor(.red))
                                }
                                
                                
                                
                                
                                
                            }
                        }.ignoresSafeArea()
                    }
                    Slider(value: $zoom.currentZoom, in: 1...10).background(Color.orange)
                }
            }
            
        }
        
    }
}

