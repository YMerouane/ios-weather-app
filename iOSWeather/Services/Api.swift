//
//  API.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

enum Api {
    fileprivate static let scheme = "https://"
    enum OpenWeatherMap {
        static let oneCallEndpoint = Api.scheme + "api.openweathermap.org/data/2.5/onecall"
        static let key = "4672f6951ef8d24128c8086d39c9a263"
        static let weatherForCity = Api.scheme + "api.openweathermap.org/data/2.5/weather"
        
    }
    
    enum Nominatim {
        static let search =  Api.scheme + "nominatim.openstreetmap.org/search"
    }
}
