//
//  HomeRouter.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func showAlert(message: String)
    func routeToSearch(source: UIViewController, destination: UIViewController)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
   
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    //MARK: Alert
    func showAlert(message: String) {
        viewController?.presentAlert(message: message)
    }
    
    
    
    //MARK: Routing
    
    func routeToSearch(source: UIViewController, destination: UIViewController) {
        let destination = UINavigationController(rootViewController: destination)
        source.present(destination, animated: true)
    }
    
}


//MARK: UITabBarDelegate
extension HomeRouter: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let source = viewController else {
            return
        }
        routeToSearch(source: source, destination: SearchViewController())
    }
}
