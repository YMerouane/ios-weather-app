//
//  ViewModelRepresentable.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//

import UIKit
protocol ViewModelRepresentable {
    
    associatedtype T
    var viewModel: T? { get }
    func populateSubviews(with viewModel: T)
    
}

