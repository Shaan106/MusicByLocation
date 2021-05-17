//
//  CLPlacemark.swift
//  MusicByLocation
//
//  Created by Aasmaan Yadav on 17/05/21.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func getLocationBreakDown() -> String {
        return
            """
            Street: \(self.thoroughfare ?? "None")
            City: \(self.locality ?? "None")
            Area: \(self.administrativeArea ?? "None")
            Country: \(self.country ?? "None")
            """
    }
}
