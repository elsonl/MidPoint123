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
    @Binding var delegatePlaceID : String
    @Binding var showPlaceID : Bool
    @Binding var showDetail : Bool

    
    let marker : GMSMarker = GMSMarker()
    let marker2 : GMSMarker = GMSMarker()
    let midpointMarker : GMSMarker = GMSMarker()
    
    
    
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        
        nearbySearch.coordinatesNS.0 = geocoding.coordinates.0
        nearbySearch.coordinatesNS.1 = geocoding.coordinates.1
        nearbySearch.coordinatesNS.2 = geocoding.coordinates.2
        nearbySearch.coordinatesNS.3 = geocoding.coordinates.3
        
        let marker1location = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        let marker2location = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        let bounds = GMSCoordinateBounds(coordinate: marker1location, coordinate: marker2location)
        
        
       
        
        var camera = GMSCameraPosition.camera(withLatitude:  (geocoding.coordinates.0! + geocoding.coordinates.2!)/2, longitude:  (geocoding.coordinates.1! + geocoding.coordinates.3!)/2, zoom: 1)
        
        let update = GMSCameraUpdate.fit(bounds, withPadding:75)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = context.coordinator
        mapView.moveCamera(update)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
     
      
    
        
        
//        placeDetails.getData(){
//        print(placeDetails.responses4.result!)
//        }
        
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
                    loopMarkers.isTappable = true
                    print("UserData : \(String(describing: loopMarkers.userData ?? "empty userdata"))")
                    loopMarkers.map = mapView
                    delegatePlaceID = placesManager.PlaceIDs[0]
                    
                }
            }else {
                print("invalid 111")
            }
            showPlaceID = true
            
            
//            for count in placesManager.Names.indices
//            {placeDetails.PlaceIDs.append(placesManager.PlaceIDs[count])
//              
//                placeDetails.count = count
//                placeDetails.getData(){
//                    
//                print(placeDetails.responses4.result!)
//                }
//            }
        }
        return mapView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(owner: self, delegatePlaceID: $delegatePlaceID, showDetail: $showDetail, placeDetails: placeDetails)
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        
        // variables for the coordinates of the midpoint
        let midLat = (geocoding.coordinates.0! + geocoding.coordinates.2!)/2
        let midLong = (geocoding.coordinates.1! + geocoding.coordinates.3!)/2
        
        // makes first marker that displays first location in red
        marker.icon = GMSMarker.markerImage(with : UIColor.red)
        marker.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
        marker.title = "Location 1"
        marker.snippet = "Marker 1"
        marker.userData = "marker 1"
        marker.map = mapView
    
        
        
        
        // makes second marker taht displays second location in green
        marker2.icon = GMSMarker.markerImage(with : UIColor.green)
        marker2.position = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
        marker2.title = "Location 2"
        marker2.snippet = "Marker 2"
        marker2.userData = "marker 2"
        marker2.map = mapView
  
        
        // makes third marker that displays midpoint in blue
        midpointMarker.icon = GMSMarker.markerImage(with : UIColor.blue)
        midpointMarker.position = CLLocationCoordinate2D(latitude:  midLat , longitude: midLong)
        midpointMarker.title = "Midpoint Marker"
        midpointMarker.snippet = "Middle"
        marker.userData = "Midpoint Marker"
        midpointMarker.map = mapView
        
        
        // makes a circle radius around the midpoint
//        var miles = placeDetail.miles
//        let circleCenter : CLLocationCoordinate2D  = CLLocationCoordinate2DMake(midLat, midLong)
//        let circ = GMSCircle(position: circleCenter, radius: 1609.34 * miles)
//        circ.fillColor = UIColor(red: 0.0, green: 0.7, blue: 0, alpha: 0.1)
//        circ.strokeColor = UIColor(red: 255/255, green: 153/255, blue: 51/255, alpha: 0.5)
//        circ.strokeWidth = 2.5
//        
//        circ.map = mapView
        
        
        // updates the view so that both markers are always visible at the same time
//        let marker1 = CLLocationCoordinate2D(latitude:  geocoding.coordinates.0!, longitude: geocoding.coordinates.1!)
//        let marker2 = CLLocationCoordinate2D(latitude:  geocoding.coordinates.2! , longitude: geocoding.coordinates.3!)
//        let bounds = GMSCoordinateBounds(coordinate: marker1, coordinate: marker2)
//
//        let update = GMSCameraUpdate.fit(bounds, withPadding:75)
//        mapView.moveCamera(update)
        
        
        
//        mapView.animate(to: GMSCameraPosition(target: midpointMarker.position, zoom: 10))
        
        
    }

class Coordinator : NSObject, GMSMapViewDelegate, ObservableObject{

    @Binding var delegatePlaceID : String
    @Binding var showDetail : Bool
    let owner : GoogleMapsView
    var placeDetails : PlaceDetails
    init(owner : GoogleMapsView, delegatePlaceID :  Binding<String>, showDetail : Binding<Bool>, placeDetails : PlaceDetails){
        self.owner = owner
        self._delegatePlaceID = delegatePlaceID
        self._showDetail = showDetail
        self.placeDetails = placeDetails
    }

     func mapView(_ mapView: GMSMapView, didTap markerDel: GMSMarker) -> Bool {
        
//        delegatePlaceID = marker.userData as! String
//        print("DelegatePlaceID\(delegatePlaceID)")
        
        print("delegate Thing")
        if markerDel.userData == nil {
            print("UserData Delegate Return False")
            return false
        }
        let markerData = markerDel.userData
        print("UserData Delegate : \(String(describing: markerData))")
        print("UserData Delegate 2 : \(String(describing: markerDel.userData))")
        
        
        delegatePlaceID = markerData as! String
        print("DelegatePlaceID \(delegatePlaceID)")
        
        showDetail = true
        
        var show : Bool = true
        placeDetails.PlaceIDs = delegatePlaceID
        print("\(placeDetails.PlaceIDs) placeDetailPlaceID")
      
        if show {
        showDetail = false
        }
        
        placeDetails.getData(){ [self] in
            
            print("\(placeDetails.responses4.result!) RESULTS" )
            print("\(placeDetails.responses4.result!.name ?? "nothing here") : name thingy")
            var name = placeDetails.responses4.result?.name ?? "nil"
            print("\(name) name")
            if name != "nil"{
                showDetail = true
                show = false
            }
            show = true
//            mapView.animate =  GMSCameraPosition.camera(withTarget: markerDel.position, zoom: 15)
            DispatchQueue.main.async {
                    mapView.animate(to: GMSCameraPosition.camera(withTarget: markerDel.position, zoom: 15))
                }
//            mapView.camera = GMSCameraPosition.camera(withTarget: markerDel.position, zoom: 15)
        }

//        let bounds = GMSCoordinateBounds(coordinate: markerDel.position, coordinate: markerDel.position)
//        mapView.camera = GMSCameraPosition.camera(withTarget: markerDel.position, zoom: 15)
//        mapView.animate(with: GMSCameraUpdate.fit(bounds))
        
        return true
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow markerDel: GMSMarker) -> UIView? {
        print("Marker Info Window")
        let mInfoWindow = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
                mInfoWindow.backgroundColor = UIColor.lightGray
                mInfoWindow.layer.cornerRadius = 6

                let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: 16, height: 15))
                lbl1.text = "Hi there!"
                mInfoWindow.addSubview(lbl1)
        
        


                return mInfoWindow
    }
    
    
}
}
