//
//  StateController.swift
//  MusicByLocation
//
//  Created by Aasmaan Yadav on 17/05/21.
//

import Foundation

class StateController: ObservableObject {
    var lastKnownLocation: String = "" {
        didSet {
            getArtists(city: lastKnownLocation)
        }
    }

    @Published var artistNames: String = ""
    
    let locationHandler: LocationHandler = LocationHandler()
    
    func findMusic() {
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists(city: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(city)&entity=musicArtist")
        else {
            print(city)
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    DispatchQueue.main.async {
                        self.artistNames = names.joined(separator: ", ")
                    }
                    
                }
            }
            
        }.resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        if let artistResponse = try? decoder.decode(ArtistResponse.self, from: json) {
            return artistResponse
        } else {
            print("error decoding json")
            return nil
        }
        
    }
}
