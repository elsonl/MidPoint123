//
//  ResultsDetailsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/30/22.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ResultsDetailsView: View {
    @EnvironmentObject var nearbySearch : NearbySearch
    @Binding var listCount : Int
    @Binding var showDetail : Bool
    @EnvironmentObject var placeDetails : PlaceDetails
    @Binding var cameraChange : Bool
    @Binding var adjustMarker : Bool
    
    
    var body: some View {
        
        if showDetail{
            
            let   name = placeDetails.responses4.result?.name ?? "no name availible"
            
            let    formattedAddress = placeDetails.responses4.result!.formatted_address ?? "no address availible"
            let      formattedPhoneNumber = placeDetails.responses4.result!.formatted_phone_number ?? "no phone number availible"
            //   let      openNow = placeDetails.responses4.result!.opening_hours.open_now
            let      openHours = placeDetails.responses4.result!.opening_hours.weekday_text
            let      rating = placeDetails.responses4.result!.rating ?? -1
            
            let  website = placeDetails.responses4.result!.website ?? "no website availible"
            
            
            let photoHeight =  placeDetails.responses4.result!.photos.first?.height ?? 0
            let photoWidth = placeDetails.responses4.result!.photos.first?.width ?? 0
            let photoHtmlAttribution = placeDetails.responses4.result!.photos.first?.html_attributions
            let photoReference = placeDetails.responses4.result!.photos.first?.photo_reference ?? "not availible"
            
            
            
            
//            List(){
            if(photoReference == "not availible"){
                Text("No Photos Availible")
            } else {
                
                KFImage(URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photo_reference=\(photoReference)&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4")).resizable().aspectRatio(contentMode: .fit)
            }

                Text(verbatim : "\(name)")
                HStack{
                    Text(verbatim : "\(formattedAddress)")
                    Button(action: {   UIPasteboard.general.string = formattedAddress
                    }) {
  
                        Image(systemName: "doc.on.doc").foregroundColor(.blue)
                    }.frame(alignment: .trailing)
                }
                HStack{
                    Text(verbatim : "\(formattedPhoneNumber)")
                    Button(action: {   UIPasteboard.general.string = formattedPhoneNumber
                    }) {
                        Image(systemName: "doc.on.doc").foregroundColor(.blue)
                    }.frame(alignment: .trailing)
                    
                }
                
                Text(verbatim : "\(openHours[0])\n\(openHours[1])\n\(openHours[2])\n\(openHours[3])\n\(openHours[4])\n\(openHours[5])\n\(openHours[6])")
                
                
                Text(verbatim : "\(rating)")
                
                
                
                
                if(website == "no website availible"){

                Text("Website Unavalible").foregroundColor(.black)
               
                } else{
                    Link("Website", destination: (URL(string: "\(website)") ?? URL(string: "google.com"))!).foregroundColor(.blue)}
                
                                
                
                //             Doesnt work :(
                //            Link("Link to Website", destination: URL(string: "website!")!)
                
                
//            }.frame( height: 350, alignment: .bottom).ignoresSafeArea().navigationTitle("Details") .navigationBarTitleDisplayMode(.inline)
            
            //        .toolbar{
            //            Button(action:{
            //                showDetail = false
            //                print(showDetail)
            //
            //            }, label: {
            //                NavigationLink(destination : GMapsView()){
            //
            //                    Text("back")
            //                }
            //            })
            //        }
        } else {
            Text("Loading...")
            
            //                .toolbar{
            //                    Button(action:{
            //                        showDetail = false
            //                        print(showDetail)
            //
            //                    }, label: {
            //                        NavigationLink(destination : GMapsView()){
            //
            //                            Text("back")
            //                        }
            //                    })
            //                }
        }
        
        
    }
}

struct ResultsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsDetailsView(listCount: .constant(0), showDetail: .constant(false), cameraChange: .constant(true), adjustMarker: .constant(true))
    }
}
