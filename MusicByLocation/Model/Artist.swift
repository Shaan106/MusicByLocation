//
//  Artist.swift
//  MusicByLocation
//
//  Created by Aasmaan Yadav on 17/05/21.
//

import Foundation

struct Artist: Codable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
    }
}
