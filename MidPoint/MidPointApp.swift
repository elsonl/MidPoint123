//
//  MidPointApp.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/17/22.
//

import SwiftUI
import GoogleMaps
import GooglePlaces
//AIzaSyCtxaHcGjWwapQCadzqom4EOBe2eTcpA-s

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        GMSServices.provideAPIKey("AIzaSyCtxaHcGjWwapQCadzqom4EOBe2eTcpA-s")
        GMSPlacesClient.provideAPIKey("AIzaSyBRE8qVO4RK_MzHvDGA33eiauyD6Mezs8Y")
        
        return true
    }
}

@main
struct MidPointApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate : AppDelegate
    @StateObject var geocoding = Geocoding()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(geocoding)
        }
    }
}
