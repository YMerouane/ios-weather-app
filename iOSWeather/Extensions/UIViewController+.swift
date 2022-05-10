//
//  UIViewController+.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//


import UIKit
extension UIViewController {
    
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: animated, completion: completion)
    }
    
    func presentAlert(message: String,
                      alertTitle: String = "Oops! Somethig went wrong",
                      alertStyle: UIAlertController.Style = .alert,
                      actionTitle: String = "Ok",
                      actionStyle: UIAlertAction.Style = .cancel) {
        let alertMessage = UIAlertController(title: alertTitle , message: message, preferredStyle: alertStyle)
        let cancelAction = UIAlertAction(title: actionTitle, style: .cancel)
        alertMessage.addAction(cancelAction)
        self.present(alertMessage, animated: true, completion: nil)
    }
}
