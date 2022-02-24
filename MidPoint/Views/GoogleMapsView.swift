//
//  GoogleMapsView.swift
//  MidPoint
//
//  Created by Elson Lin (student LM) on 2/23/22.
//

import MapKit
import SwiftUI
import UIKit
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    @ObservedObject var geocoding =  Geocoding()
    let marker : GMSMarker = GMSMarker()
    
    
    func makeUIView(context: Self.Context) -> GMSMapView {
    
        
        var lat : Double = geocoding.responses.results.last?.geometry.first?.location.lat ?? 0
        var long : Double = geocoding.responses.results.first?.geometry.last?.location.lng ?? 0
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)

        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
        
        var lat : Double = geocoding.responses.results.first?.geometry.first?.location.lat ?? 0
        var long : Double = geocoding.responses.results.first?.geometry.first?.location.lng ?? 0
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long ?? 1)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }

}
