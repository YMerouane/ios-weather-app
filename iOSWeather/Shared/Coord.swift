//
//  Coordinates.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 18.01.2022.
//

import Foundation

final class Coord: NSObject  {
    let lat: String
    let lon: String
    var isValid: Bool {
        return !lat.isEmpty && !lon.isEmpty
    }
    init(lat: String, lon: String) {
        self.lat = lat
        self.lon = lon
    }
}
