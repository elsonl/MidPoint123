

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
    @EnvironmentObject var dMatrix : DistanceMatrix
    @EnvironmentObject var placeDetail : PlaceDetail
    @Binding var PlaceIDResults : [String]
    
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
            
            
            Spacer()
            List(){
                
                VStack{
                    HStack{
                    VStack{
                    if(photoReference == "not availible"){
                        Text("No Photos Availible")
                    } else {
                        
                        KFImage(URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photo_reference=\(photoReference)&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4")).resizable().frame(width: 125, height: 125, alignment: .leading).aspectRatio(contentMode: .fit)
                    }
                    HStack{
                                       if(rating<=0.5){
                                           Image("starhalf").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=1){
                                           Image("star").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=1.5){
                                           Image("starhalf1").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=2){
                                           Image("star1").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=2.5){
                                           Image("starhalf2").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=3){
                                           Image("star2").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=3.5){
                                           Image("starhalf3").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=4){
                                           Image("star3").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else if(rating<=4.5){
                                           Image("starhalf4").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }else{
                                           Image("star4").resizable().frame(width: 110, height: 30, alignment: .center)
                                       }
                                       Text(verbatim: "(\(rating))")
                                   }
                    }
                        VStack(alignment: .center){
                            Text("Name: ").bold() + Text(verbatim : "\(name)")
                            Divider()
                            HStack(alignment: .top){
                            Text("Address: ").bold() + Text(verbatim : "\(formattedAddress)")

                                            Button(action: {   UIPasteboard.general.string = formattedAddress
                                            }) {

                                                Image(systemName: "doc.on.doc").foregroundColor(.blue)
                                            }
                                        }
                                        HStack(alignment: .top){
                                            Text("Phone Num: ").bold() + Text(verbatim : "\(formattedPhoneNumber)")
                                            Button(action: {   UIPasteboard.general.string = formattedPhoneNumber
                                            }) {
                                                Image(systemName: "doc.on.doc").foregroundColor(.blue)
                                            }
                                        }
                            Text("Hours: ").bold()
                            Text(verbatim :" \(openHours[0])\n\(openHours[1])\n\(openHours[2])\n\(openHours[3])\n\(openHours[4])\n\(openHours[5])\n\(openHours[6])")
                            
                            if(website == "no website availible"){
                                Text("Website: ").bold() + Text("Website Unavailible").foregroundColor(.black)
                                            } else {
                       Text("Website: ").bold()
                        Link("\(name) Website", destination: (URL(string: "\(website)") ?? URL(string: "google.com"))!).foregroundColor(.blue).frame(alignment: .leading)
                                            }
                        }
                }
                        
                        
Text("From Location 1 : \(PlaceIDResults[1])")
Text("From Location 2 : \(PlaceIDResults[3])")
                        
                    
                }.font(Font.system(size: 10))
                
//                                Text(verbatim : "\(name)")
//                                HStack{
//                                    Text(verbatim : "\(formattedAddress)")
//
//                                    Button(action: {   UIPasteboard.general.string = formattedAddress
//                                    }) {
//
//                                        Image(systemName: "doc.on.doc").foregroundColor(.blue)
//                                    }
//                                }
//                                HStack{
//                                    Text(verbatim : "\(formattedPhoneNumber)")
//                                    Button(action: {   UIPasteboard.general.string = formattedPhoneNumber
//                                    }) {
//                                        Image(systemName: "doc.on.doc").foregroundColor(.blue)
//                                    }
//                                }
                //
                //                Text(verbatim : "Hours: \n\(openHours[0])\n\(openHours[1])\n\(openHours[2])\n\(openHours[3])\n\(openHours[4])\n\(openHours[5])\n\(openHours[6])")
                //
                //                HStack{
                //                    if(rating<=0.5){
                //                        Image("starhalf")
                //                    }else if(rating<=1){
                //                        Image("star")
                //                    }else if(rating<=1.5){
                //                        Image("starhalf1")
                //                    }else if(rating<=2){
                //                        Image("star1")
                //                    }else if(rating<=2.5){
                //                        Image("starhalf2")
                //                    }else if(rating<=3){
                //                        Image("star2")
                //                    }else if(rating<=3.5){
                //                        Image("starhalf3")
                //                    }else if(rating<=4){
                //                        Image("star3")
                //                    }else if(rating<=4.5){
                //                        Image("starhalf4")
                //                    }else{
                //                        Image("star4")
                //                    }
                //                    Text(verbatim: "(\(rating))")
                //                }
                //
                //
                //                if(website == "no website availible"){
                //                    Text("Website Unavailible").foregroundColor(.black)
                //                } else {
                //                Link("Website", destination: (URL(string: "\(website)") ?? URL(string: "google.com"))!).foregroundColor(.blue)
                //                }
                //
                //                if(photoReference == "not availible"){
                //                    Text("No Photos Availible")
                //                } else {
                //
                //                    KFImage(URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&maxheight=400&photo_reference=\(photoReference)&key=AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4")).resizable().aspectRatio(contentMode: .fit)
                //                }
                
                
                //             Doesnt work :(
                //            Link("Link to Website", destination: URL(string: "website!")!)
                
                
            }.frame( height: 350, alignment: .bottom).ignoresSafeArea().navigationTitle("Details") .navigationBarTitleDisplayMode(.inline)
            
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
