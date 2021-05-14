//
//  ContentView.swift
//  MusicByLocation
//  Now it works
//  Created by Khemaney, Akshay (SPH) on 13/05/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        Form {
            Text("Street: \(locationHandler.lastKnownLocation.street)")
            Text("City: \(locationHandler.lastKnownLocation.city)")
            Text("Country: \(locationHandler.lastKnownLocation.country)")
            Text("Post Code: \(locationHandler.lastKnownLocation.postCode)")
            Button("Find Music", action: {
                locationHandler.requestLocation()
            })
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
