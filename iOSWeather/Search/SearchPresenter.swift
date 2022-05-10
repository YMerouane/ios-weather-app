//
//  SearchPresenter.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import UIKit

enum SearchPresentationError: Error , CustomStringConvertible{
    case build
    var description: String {
        switch self {
        case .build:
            return "Cannont build view model"
        }
    }
}

protocol SearchPresentationLogic {
    typealias Response = [Search.Responses.Place]
    func present(error: Error)
    func presentCities(response: Response)
   
}

class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    // MARK: Do something
    func present(error: Error) {
        let message = error.localizedDescription
        viewController?.displayError(message: message)
    }
    
    func presentCities(response: [Search.Responses.Place]) {
        let viewModel = buildViewModel(with: response)
        viewController?.displayCities(viewModel: viewModel)
    }
    
}

extension SearchPresenter {
    func buildViewModel(with model: [Search.Responses.Place]) -> Search.ViewModels.ViewModel {
        let items = model.map {
            Search.ViewModels.PlaceViewModel(
                lat: $0.lat,
                lon: $0.lon,
                name: $0.displayName
            )
        }
        return Search.ViewModels.ViewModel(itemViewModels: items)
    }
}
