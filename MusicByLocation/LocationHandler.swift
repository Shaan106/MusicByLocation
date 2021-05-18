//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Khemaney, Akshay (SPH) on 13/05/2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    weak var stateController: StateController?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.stateController?.lastKnownLocation = "Error"
//                    self.lastKnownLocation.city = "Error"
//                    self.lastKnownLocation.country = "Error"
//                    self.lastKnownLocation.postCode = "Error"
//                    self.lastKnownLocation.thoroughfare = "Error"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.stateController?.lastKnownLocation = firstPlacemark.getCity()
//                        self.lastKnownLocation.street = firstPlacemark.thoroughfare ?? "Couldn't Find Thoroughfare"
//                        self.lastKnownLocation.city = firstPlacemark.locality ?? "Couldn't Find Locality"
//                        self.lastKnownLocation.country = firstPlacemark.country ?? "Couldn't Find Locality"
//                        self.lastKnownLocation.postCode = firstPlacemark.postalCode ?? "Couldn't Find Locality"
//                        self.lastKnownLocation.thoroughfare = firstPlacemark.subThoroughfare ?? "Couldn't find Stuff and things"
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.stateController?.lastKnownLocation = "Error Finding Location"
    }
}
