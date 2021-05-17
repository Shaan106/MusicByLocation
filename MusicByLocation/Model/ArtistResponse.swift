//
//  ArtistResponse.swift
//  MusicByLocation
//
//  Created by Aasmaan Yadav on 17/05/21.
//

import Foundation

struct ArtistResponse: Codable {
    var count: Int
    var results: [Artist]
    
    private enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
}
