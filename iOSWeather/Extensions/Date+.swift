//
//  Date+StringValue.swift
//  iOSWeather
//
//  Created by MEROUANE Yassine.
//
import Foundation

extension Date {
    func stringFromDate(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
}
