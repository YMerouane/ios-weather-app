//
//  SearchRouter.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import UIKit

@objc
protocol SearchRoutingLogic {
    func showAlert(message: String)
    func routeToHome(with placeName: String, and coord: Coord)
    func navigateToHome(source: SearchViewController?,
                        destination: HomeViewController?)
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get set }
    func pass(placeName: String?, with coord: Coord, to destination: inout HomeDataStore?)
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    
    weak var viewController: SearchViewController?
    
    var dataStore: SearchDataStore?
    //MARK: Alert
    func showAlert(message: String) {
        viewController?.presentAlert(message: message)
    }
    //MARK: Route
    func routeToHome(with placeName: String,and coord: Coord) {
        guard let destinationVC = viewController?.presentingViewController as? HomeViewController
        else {
            let message = "No appropriate View Controller to route on"
            viewController?.router?.showAlert(message: message)
            return
        }
        var destionationDS = destinationVC.router?.dataStore
        pass(placeName: placeName, with: coord, to: &destionationDS)
        navigateToHome(source: viewController, destination: destinationVC)
        
    }
    //MARK: Passing data
    func pass(placeName: String?, with coord: Coord, to destination: inout HomeDataStore?) {
        destination?.placeName = placeName
        destination?.coord = coord
    }
    
    //MARK: Navigation
    func navigateToHome(source: SearchViewController?, destination: HomeViewController?) {
        source?.navigationController?.dismiss(animated: true) {
            destination?.getCityForecast()
        }
        
    }
    
}
