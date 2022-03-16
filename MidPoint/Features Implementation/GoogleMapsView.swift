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
    let midpointMarker : GMSMarker = GMSMarker()
    
    
    
    
    
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        var camera = GMSCameraPosition.camera(withLatitude:  (geocoding.coordinates.0! + geocoding.coordinates.2!)/2, longitude:  (geocoding.coordinates.1! + geocoding.coordinates.3!)/2, zoom: 1)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        
        
        
        return mapView
        
        
        
    }
    
    
    
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        let midLat = (geocoding.coordinates.0! + geocoding.coordinates.2!)/2
        let midLong = (geocoding.coordinates.1! + geocoding.coordinates.3!)/2
    
        
        marker.icon = GMSMarker.markerImage(with : UIColor.red)
        marker.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        marker.title = "Location 1"
        marker.snippet = "Marker 1"
        marker.map = mapView
        
        
        
        marker2.icon = GMSMarker.markerImage(with : UIColor.green)
        marker2.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        marker2.title = "Location 2"
        marker2.snippet = "Marker 2"
        marker2.map = mapView
        
        midpointMarker.icon = GMSMarker.markerImage(with : UIColor.orange)
        midpointMarker.position = CLLocationCoordinate2D(latitude:  midLat , longitude: midLong)
        midpointMarker.title = "Midpoint Marker"
        midpointMarker.snippet = "Middle"
        midpointMarker.map = mapView
        
        
        
        
        
        let marker1 = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        let marker2 = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        let bounds = GMSCoordinateBounds(coordinate: marker1, coordinate: marker2)
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.moveCamera(update)
        
        
        //        var bounds = GMSCoordinateBounds()
        //        for location in locationArray
        //        {
        //            let latitude = location.valueForKey("latitude")
        //            let longitude = location.valueForKey("longitude")
        
        //            let marker = GMSMarker()
        //            marker.position = CLLocationCoordinate2D(latitude:latitude, longitude:longitude)
        //            marker.map = self.mapView
        //            bounds = bounds.includingCoordinate(marker.position)
        //        }
        //        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        //        mapView.animate(update)
        
        
        
        
    }
    
    
    
    
}

