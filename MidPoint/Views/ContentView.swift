//
//  ContentView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/17/22.
//

import SwiftUI
import GoogleMaps
import GooglePlaces
import struct Kingfisher.KFImage

struct ContentView: View {
    @EnvironmentObject var geocoding : Geocoding
    @EnvironmentObject var dMatrix : DistanceMatrix
    @State var address1 : String
    @State var address2: String
    @State private var showsheet1 = false
    @State private var showsheet2 = false
    @State var favorites : [String: String] = [:] //name:address
    @State var favoritesName : String = ""
    @State var favoritesAddress : String = ""
    @State var favoritesOpen : Bool = false
    @State var favoritesToggle : Bool = false
    @State var delegatePlaceID : String
    
    
    var body: some View {
        
        
        NavigationView{
            ZStack{
                //background here random cities
//                KFImage(URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=Aap_uEA7vb0DDYVJWEaX3O-AtYp77AaswQKSGtDaimt3gt7QCNpdjp1BkdM6acJ96xTec3tsV_ZJNL_JP-lqsVxydG3nh739RE_hepOOL05tfJh2_ranjMadb3VoBYFvF0ma6S24qZ6QJUuV6sSRrhCskSBP5C1myCzsebztMfGvm7ij3gZT&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4")).resizable().aspectRatio(contentMode: .fit)
//
//                Image("Map") .resizable().opacity(0.8).aspectRatio(contentMode: .fit)
                
//                Color.white
                //Image().aspectRatio image here resize
                VStack{
                    Group{
                        Image("InAppIcon")
                        Text("MidPoint").foregroundColor(Color.gray) //(distance done easy)
                        //No Space Here, no time to fix
                        Text("Enter Locations Below")
                            .foregroundColor(Color.gray)
                            .padding()
                        
                        //Address1
                        HStack{
                            Image(systemName: "magnifyingglass").foregroundColor(Color.gray) .font(Font.system(size: 35, weight: .heavy))
                            
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
                            })
                                .foregroundColor(Color.black).background(Color(.systemGray4)).textFieldStyle(RoundedBorderTextFieldStyle())
                                .sheet(isPresented : $showsheet1, onDismiss: {
                                    
//                                    if(address1 == ""){
//                                        print("address 1 empty, showsheet true")
//                                        showsheet1 = true
//                                    } else {
                                        geocoding.count = true
                                        
                                        print(geocoding.count)
                                        print("in else")
                                        
                                        print("showsheet1false")
                                        showsheet1 = false
                                        geocoding.getData()
                                        
//                                    }
                                }) { PlacesAutoComplete(geocoding: _geocoding, dMatrix: _dMatrix, address1: $address1, address2: $address2, favoritesAddress: $favoritesAddress)
                                    .environmentObject(geocoding) }
                        }.frame(width: 375, alignment: .trailing)
                        
                        Spacer().frame(height: 25)
                        
                        //Address 2
                        HStack {
                            Image(systemName: "magnifyingglass").foregroundColor(Color.gray).font(Font.system(size : 35, weight: .heavy))
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
//                                    if(address2 == ""){
//                                        print("address 2 empty, showsheet true")
//                                        showsheet2 = true
//                                    } else {
                                        geocoding.count = false
                                        
                                        print(geocoding.count)
                                        print("in else")
                                        
                                        print("showsheet2false")
                                        showsheet2 = false
                                        geocoding.getData()
                                        
                                        
//                                    }
                                }) { PlacesAutoComplete(geocoding: _geocoding, address1: $address1, address2: $address2, favoritesAddress: $favoritesAddress)
                                    .environmentObject(geocoding) }}.frame(width: 375, alignment: .trailing)
                        
                        Spacer().frame(height: 15)
                        
                        //Search Button
                        
                        Button(action : {
                            
                        }, label: {
                            NavigationLink(destination : GMapsView( delegatePlaceID: $delegatePlaceID)){
                                
                                Text("Search")
                                
                            }
                        }).padding().background(Color.FavoritesBackground).clipShape(Capsule()).foregroundColor(.black)
                        
                        Spacer().frame(height: 35)
                    }
                    //
                    //Favorites
                    
                    HStack{
                        Button(action: {favoritesToggle.toggle()}){
                            if(favoritesToggle){
                                VStack{
                                    ZStack{
                                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)).frame(width: 100, height: 50, alignment: .center).foregroundColor(.gray)
                                        HStack{
                                            Spacer()
                                            Text("Favorites")
                                            Spacer()
                                            Image(systemName: "arrowtriangle.down.fill").foregroundColor(.gray)
                                            Spacer()
                                        }
                                    }
                                    Group{
                                        ZStack {
                                            //Grey Background
                                            Rectangle().foregroundColor(Color.yellow).frame(width: 350, height: 140, alignment: .center).cornerRadius(35).padding()
                                            VStack{
                                                ScrollView(.horizontal){
                                                    
                                                    HStack(spacing : 15){
                                                        //Add/Edit Favorites
                                                        
                                                        Button(action: {print("button pressed")}, label: {
                                                            
                                                            NavigationLink(destination: FavoritesView(favoritesName: $favoritesName, favoritesAddress: $favoritesAddress, favorites: $favorites, address1: $address1, address2: $address2, favoritesOpen: $favoritesOpen), isActive: $favoritesOpen, label: {
                                                                
                                                                Button(action: {favoritesOpen=true}, label: {
                                                                    VStack{
                                                                        //Text Inside
                                                                        Group{
                                                                            Text("Add/Edit").padding([.top, .horizontal])
                                                                            Text("Favorites").padding([.bottom, .horizontal])
                                                                        }
                                                                    }
                                                                    
                                                                }).frame(width: 120, height: 100, alignment: .center)
                                                                
                                                            }).onDisappear(perform:{
                                                                
                                                                favorites.updateValue(favoritesAddress, forKey: favoritesName)
                                                                
                                                            })
                                                            
                                                            NavigationLink(destination: EmptyView()){
                                                                EmptyView()
                                                            }
                                                        })
                                                            .background(Color.black)
                                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                                            .foregroundColor(.white)
                                                            .frame(width: 100, height: 100, alignment: .center)
                                                            .padding(.trailing, 9)
                                                            .padding(.leading, 15)
                                                        
                                                        //Red Favorites
                                                        
                                                        ForEach(favorites.keys.sorted(), id: \.self){
                                                            Text($0)
                                                        }.frame(width: 100, height: 100, alignment: .center)
                                                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.gray))
                                                        
                                                        
                                                    }
                                                }.padding().frame(width: 381, height: 125, alignment: .center)
                                            }
                                        } //VStack Close
                                    } //ZStack Close
                                }
                                
                            }else{
                                
                                HStack{
                                    Spacer()
                                    Text("Favorites")
                                    Spacer()
                                    Image(systemName: "arrowtriangle.down.fill").rotationEffect(Angle(radians: -Double.pi/2.0)).foregroundColor(.gray)
                                    Spacer()
                                }
                            }
                        }
                        Spacer()
                        
                    }
                    
                }
            }.ignoresSafeArea()
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView(address1: "", address2: "", delegatePlaceID: "")
        }
    }
}

