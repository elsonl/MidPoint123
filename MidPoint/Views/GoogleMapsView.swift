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

struct GoogleMapsView: UIViewRepresentable{
    @EnvironmentObject var geocoding : Geocoding
    let marker : GMSMarker = GMSMarker()
    let marker2 : GMSMarker = GMSMarker()
    
    
    
    
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        
        var camera = GMSCameraPosition.camera(withLatitude:  (geocoding.coordinates.0! + geocoding.coordinates.2!)/2, longitude:  (geocoding.coordinates.1! + geocoding.coordinates.3!)/2, zoom: 5)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.compassButton = true
    
        
        return mapView
        
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
        
        
        marker.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        marker.title = "Location 1"
        marker.snippet = "Marker 1"
        marker.map = mapView
        
        
        marker2.icon = GMSMarker.markerImage(with : UIColor.green)
        marker2.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        marker2.title = "Location 2"
        marker2.snippet = "Marker 2"
        marker2.map = mapView
        
        
    }
    


    
}

