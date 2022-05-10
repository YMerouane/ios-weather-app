//
//  UILabel+ConvenienceInit.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//
import UIKit

extension UILabel {
    convenience init(transparent: Bool = false ,
                     alignment: NSTextAlignment = .center,
                     font: UIFont) {
        self.init()
        self.textColor = transparent ? .weatherTransparent : .weatherWhite
        self.textAlignment = alignment
        self.numberOfLines = 1
        self.font = font
    }
}
