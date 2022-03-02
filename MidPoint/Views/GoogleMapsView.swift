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
    @Binding var count : Bool
    let marker : GMSMarker = GMSMarker()
    let marker2 : GMSMarker = GMSMarker()


    func makeUIView(context: Self.Context) -> GMSMapView {



        var lat : Double? = geocoding.responses.results.first?.geometry.location.lat ?? 0
        var long : Double? = geocoding.responses.results.first?.geometry.location.lng ?? 0

        let camera = GMSCameraPosition.camera(withLatitude:  lat!, longitude:  long!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.scrollGestures = true
         mapView.settings.zoomGestures = true
        mapView.settings.compassButton = true
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        // Creates a marker in the center of the map.
  
        var lat1  : Double? = geocoding.responses.results.first?.geometry.location.lat ?? 0
        var long1  : Double? = geocoding.responses.results.first?.geometry.location.lng ?? 0
            
            marker.position = CLLocationCoordinate2D(latitude:  lat1!, longitude: long1!)
            marker.title = "Sydney"
            marker.snippet = "Australia"
            marker.map = mapView
            
        var lat2 : Double? = geocoding.responses.results.first?.geometry.location.lat ?? 0.5
            var long2  : Double? = geocoding.responses.results.first?.geometry.location.lng ?? 0.5
                
                marker2.position = CLLocationCoordinate2D(latitude:  lat2!, longitude: long2!)
                marker2.title = "Sydney"
                marker2.snippet = "Australia"
                marker2.map = mapView
        
      
        
       

    
    }

    }

