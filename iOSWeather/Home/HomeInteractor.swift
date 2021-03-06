//
//  HomeInteractor.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import Foundation
enum HomeInteractorError: Error, CustomStringConvertible {
    case badCoordinates
    var description: String {
        switch self {
        case .badCoordinates:
            return "No appropriate coordinate to obtain weather"
        }
    }
}
protocol HomeBusinessLogic {
    func getWeather(for coord: Coord)
    func getPlaceForecast()
}

protocol HomeDataStore {
    
    var coord: Coord? { get set }
    var placeName: String? { get set }
}

class HomeInteractor: NSObject, HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    
    var coord: Coord?
    var placeName: String?
    
    func getPlaceForecast() {
        guard let coord = coord, coord.isValid else {
            presenter?.present(error: HomeInteractorError.badCoordinates)
            return
        }
        getWeather(for: coord)
    }
    
    // MARK: Get Forecast with location coordinates
    func getWeather(for coord: Coord) {
        let request = Home.Requests.Request(lat: coord.lat, lon: coord.lon)
        worker = HomeWorker()
        worker?.request(request) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case.failure(let error):
                self.presenter?.present(error: error)
            case.success(let response):
                self.presenter?.presentWeather(for: self.placeName, with: response)
            }
        }
        
    }
    
}

