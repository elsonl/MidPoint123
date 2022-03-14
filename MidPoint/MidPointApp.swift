//
//  MidPointApp.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/17/22.
//

import SwiftUI
import GoogleMaps
import GooglePlaces


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        GMSServices.provideAPIKey("AIzaSyD6Gmm-48hyi_dtHsTgeo_yUPWvABGunoo")
        GMSPlacesClient.provideAPIKey("AIzaSyCO0auMyg79gTc2R0p1B4p4STTQsGcvJY4")
        
        return true
    }
}

@main
struct MidPointApp: App {
    //ChIJXwbcTpvAxokRpQBerYSgPqs
    @UIApplicationDelegateAdaptor private var appDelegate : AppDelegate
    
    @StateObject var geocoding = Geocoding(placeIDThing: "", count: false)
    @StateObject var dMatrix = DistanceMatrix()
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView(address1: "", address2: "")
                .environmentObject(geocoding)
                .environmentObject(dMatrix)
               
            
        }
    }
}
