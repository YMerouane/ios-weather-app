//
//  String+emptySting.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 16.01.2022.
//

import Foundation
extension String {
    static var emptyString: String {
        return ""
    }
    static var space: String {
        return " "
    }
    var isValid: Bool {
        return self.first != " " && self.last != " "
    }
    static var degree: String {
        return  "°"
    }
    static var underScore: String {
        return "_"
    }
    static var sun: String {
        return "☼"
    }
    static var slash: String {
        return "/"
    }
    static var questionMark: String {
        return "?"
    }
    static var exclamationMark: String {
        return "!"
    }
    static var percent: String {
        return "%"
    }
    static var png: String {
        return ".png"
    }
    static var jpg: String {
        return ".jpg"
    }
    static var comma: String {
        return ","
    }
    
}
