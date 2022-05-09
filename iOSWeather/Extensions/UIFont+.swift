//
//  UIFont+WeatherFonts.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

extension UIFont {
    
    static var locationLabel: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.04), weight: .medium)
    }
    
    static var temperatureLight: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .light)
    }
    static var day: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.02), weight: .regular)
    }
    static var place: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.022), weight: .medium)
    }
    static var temperatureRegular: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .regular)
    }
    static var temperatureHeader: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.08), weight: .light)
        
    }
    static var degree: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.03),weight: .light)
    }
    static var overView: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.022), weight: .light)
    }
    static var dayTitle: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.025), weight: .light)
    }
    static var extendedInfoTitle: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.02), weight: .light)
        
    }
    static var extendedInfoValue: UIFont {
        UIFont.systemFont(ofSize: (Screen.height * 0.032), weight: .regular)
        
    }
    
}
