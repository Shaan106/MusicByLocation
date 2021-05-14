//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Khemaney, Akshay (SPH) on 13/05/2021.
//

import Foundation
import CoreLocation

struct Location {
    var street: String = ""
    var city: String = ""
    var country: String = ""
    var postCode: String = ""
}

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation = Location()
    
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
                    self.lastKnownLocation.street = "Error"
                    self.lastKnownLocation.city = "Error"
                    self.lastKnownLocation.country = "Error"
                    self.lastKnownLocation.postCode = "Error"
                } else {
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnownLocation.street = firstPlacemark.thoroughfare ?? "Couldn't Find Thoroughfare"
                        self.lastKnownLocation.city = firstPlacemark.locality ?? "Couldn't Find Locality"
                        self.lastKnownLocation.country = firstPlacemark.country ?? "Couldn't Find Locality"
                        self.lastKnownLocation.postCode = firstPlacemark.postalCode ?? "Couldn't Find Locality"
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation.street = "Error Finding Location"
        lastKnownLocation.city = "Error Finding Location"
        lastKnownLocation.country = "Error Finding Location"
        lastKnownLocation.postCode = "Error Finding Location"
    }
}
