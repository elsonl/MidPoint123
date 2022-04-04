//
//  LocationManager.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 3/29/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

   
    
    
}

extension LocationManager : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }

}

