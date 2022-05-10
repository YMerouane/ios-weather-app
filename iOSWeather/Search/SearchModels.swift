//
//  SearchModels.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import UIKit

enum Search {
    // MARK: Requests
    enum Requests {
        struct CitiesRequest: NetworkRequest {
            var httpMethod: HTTPMethod = .get
            typealias NetworkResponse = [Search.Responses.Place]
            var url: String = Api.Nominatim.search
            var queries: [String : String] = [
                "format": "json",
                "accept-language": "en"
            ]
            
            init(cityName: String) {
                queries.updateValue(cityName, forKey: "city")
            }
        }
        
        
    }
    
    enum Responses {
        //City Name
        struct Place: Decodable {
            let lat, lon: String
            let displayName: String
            
        }
        
    }
    
    enum ViewModels {
        class ViewModel: SectionWithItemsViewModel {
            init(itemViewModels: [PlaceViewModel] = []) {
                self.itemViewModels = itemViewModels
            }
            
            let itemViewModels: [PlaceViewModel]
            func itemViewModel(at indexPath: IndexPath) -> PlaceViewModel {
                return itemViewModels[indexPath.row]
            }
        }
        
        struct PlaceViewModel {
            init(lat: String = .emptyString,
                 lon: String = .emptyString,
                 name: String = .emptyString) {
                self.latitude = lat
                self.longitude = lon
                self.name = name
            }
            
            let latitude: String
            let longitude: String
            let name: String
        }
    }
    
}
