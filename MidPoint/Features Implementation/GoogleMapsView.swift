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
import GooglePlaces

struct GoogleMapsView: UIViewRepresentable{
    @EnvironmentObject var geocoding : Geocoding
    @EnvironmentObject var placeDetail : PlaceDetail
    @EnvironmentObject var nearbySearch : NearbySearch
    @EnvironmentObject var placesManager : PlacesManager
    @EnvironmentObject var placeDetails : PlaceDetails
    
    let marker : GMSMarker = GMSMarker()
    let marker2 : GMSMarker = GMSMarker()
    let midpointMarker : GMSMarker = GMSMarker()
    
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        var camera = GMSCameraPosition.camera(withLatitude:  (geocoding.coordinates.0! + geocoding.coordinates.2!)/2, longitude:  (geocoding.coordinates.1! + geocoding.coordinates.3!)/2, zoom: 1)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        
        nearbySearch.coordinatesNS.0 = geocoding.coordinates.0
        nearbySearch.coordinatesNS.1 = geocoding.coordinates.1
        nearbySearch.coordinatesNS.2 = geocoding.coordinates.2
        nearbySearch.coordinatesNS.3 = geocoding.coordinates.3
        
        placeDetails.getData(){
        print(placeDetails.responses4.result!)
        }
        
        nearbySearch.getData(){
            placesManager.nearbySearch = nearbySearch
     
            if  nearbySearch.responses3.results.first?.name != nil{
                
                placesManager.getCoords()
                for count in placesManager.Names.indices{
                    let placeName = placesManager.Names[count]
                    let placeID = placesManager.PlaceIDs[count]
                    let position = CLLocationCoordinate2D(latitude: placesManager.Latitudes[count], longitude: placesManager.Longitudes[count])
                    let loopMarkers = GMSMarker(position: position)
                    loopMarkers.title = placeName
                    loopMarkers.userData = placeID
                    loopMarkers.map = mapView
                    
                }
            }else {
                print("invalid 111")
            }
        }
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
        
        // variables for the coordinates of the midpoint
        let midLat = (geocoding.coordinates.0! + geocoding.coordinates.2!)/2
        let midLong = (geocoding.coordinates.1! + geocoding.coordinates.3!)/2
        
        // makes first marker that displays first location in red
        marker.icon = GMSMarker.markerImage(with : UIColor.red)
        marker.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        marker.title = "Location 1"
        marker.snippet = "Marker 1"
        marker.map = mapView
        
        
        
        // makes second marker taht displays second location in green
        marker2.icon = GMSMarker.markerImage(with : UIColor.green)
        marker2.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        marker2.title = "Location 2"
        marker2.snippet = "Marker 2"
        marker2.map = mapView
        
        // makes third marker that displays midpoint in blue
        midpointMarker.icon = GMSMarker.markerImage(with : UIColor.blue)
        midpointMarker.position = CLLocationCoordinate2D(latitude:  midLat , longitude: midLong)
        midpointMarker.title = "Midpoint Marker"
        midpointMarker.snippet = "Middle"
        midpointMarker.map = mapView
        
        // makes a circle radius around the midpoint
        var miles = placeDetail.miles
        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(midLat, midLong)
        let circ = GMSCircle(position: circleCenter, radius: 1609.34 * miles)
        circ.fillColor = UIColor(red: 0.0, green: 0.7, blue: 0, alpha: 0.1)
        circ.strokeColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
        circ.strokeWidth = 2.5
        
        circ.map = mapView
        
        
        // updates the view so that both markers are always visible at the same time
        let marker1 = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        let marker2 = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        let bounds = GMSCoordinateBounds(coordinate: marker1, coordinate: marker2)
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.moveCamera(update)
        
    }
}
class GoogleMapsDelegate : NSObject, ObservableObject, GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if marker.userData == nil {
            return false
        }
        print(marker.userData)
        return true
    }
    
}
