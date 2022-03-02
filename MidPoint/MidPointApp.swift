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
    
    @UIApplicationDelegateAdaptor private var appDelegate : AppDelegate
    @StateObject var geocoding = Geocoding(placeIDThing: Binding.constant(""), placeIDs: Binding.constant(["",""]), count: Binding.constant(true))
 
    var body: some Scene {

        WindowGroup {

            ContentView(address1: "", address2: "", placeIDThing: Binding.constant("") )
                .environmentObject(geocoding)
        }
    }
}
