//
//  CGColor+.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 18.01.2022.
//


import UIKit
extension CGColor {
    
    static var randomGradientPair: [CGColor] {
        var gray: [CGColor] {
            return [
                UIColor.lightGray.cgColor,
                UIColor.darkGray.cgColor
            ]
            
        }
        return Self.colorPairs.randomElement() ?? gray
    }
    
    fileprivate static var colorPairs: [[CGColor]] {
        return [
            CGColor.colors1,
            CGColor.colors2,
            CGColor.colors3,
            CGColor.colors4,
            CGColor.colors5,
            CGColor.colors6,
            CGColor.colors7
        ]
    }
    fileprivate static var colors1: [CGColor] {
        return [
            UIColor(red: 0.219125, green: 0.884261, blue: 0.853127, alpha: 1).cgColor,
            UIColor(red: 0.347182, green: 0.254881, blue: 0.409105, alpha: 1).cgColor
        ]
    }
    fileprivate static var colors2: [CGColor] {
        return [
            UIColor(red: 0.0167274, green: 0.392331, blue: 0.730595, alpha: 1).cgColor,
            UIColor(red: 0.824036, green: 0.15254, blue: 0.64217, alpha: 1).cgColor
        ]
    }
    
    fileprivate static var colors3: [CGColor] {
        return [
            UIColor(red: 0.76031, green: 0.601329, blue: 0.369621, alpha: 1).cgColor,
            UIColor(red: 0.397339, green: 0.0682493, blue: 0.00361688, alpha: 1).cgColor
        ]
    }
    fileprivate static var colors4: [CGColor] {
        return [
            UIColor(red: 0.178845, green: 0.506461, blue: 0.883807, alpha: 1).cgColor,
            UIColor(red: 0.475444, green: 0.364622, blue: 0.669824, alpha: 1).cgColor
          
        ]
    }
    fileprivate static var colors5: [CGColor] {
        return [
            UIColor(red: 0.643615, green: 0.460395, blue: 0.850782, alpha: 1).cgColor,
            UIColor(red: 0.0264209, green: 0.291293, blue: 0.364349, alpha: 1).cgColor
          
        ]
    }
    fileprivate static var colors6: [CGColor] {
        return [
            UIColor(red: 0.353715, green: 0.677161, blue: 0.728125, alpha: 1).cgColor,
            UIColor(red: 0.1609, green: 0.519066, blue: 0.341617, alpha: 1).cgColor
        ]
    }
    fileprivate static var colors7: [CGColor] {
        return [
            UIColor(red: 0.941176, green: 0.498039, blue: 0.352941, alpha: 1).cgColor,
            UIColor(red: 0.135266, green: 0.628718, blue: 0.70031, alpha: 1).cgColor
        ]
    }
   
   
}

