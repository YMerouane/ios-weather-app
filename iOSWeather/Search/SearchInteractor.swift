//
//  SearchInteractor.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import UIKit

protocol SearchBusinessLogic {
    func searchCities(name: String)
   
        
    
}

protocol SearchDataStore {
    
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
  
    var presenter: SearchPresentationLogic?
    var worker: SearchWorker?
    // MARK: Search Cities
    func searchCities(name: String) {
        guard name.isValid else {
            presenter?.presentCities(response: [])
            return
        }
        let request = Search.Requests.CitiesRequest(cityName: name)
        worker = SearchWorker()
        worker?.request(request, completion: { result in
            switch result {
            case.failure(let error):
                self.presenter?.present(error: error)
            case.success(let response):
                self.presenter?.presentCities(response: response)
            }
        })

    }
}
