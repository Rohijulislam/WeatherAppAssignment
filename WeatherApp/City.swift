//
//  City.swift
//  WeatherApp
//
//  Created by Md. Rohejul Islam on 30/10/22.
//

import Foundation

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coordinate
    let country: String
    let population, timezone, sunrise, sunset: Int
    
    func sunriseTime() -> String {
        return CommonUtility.sharedInstance.getTime(since1970: Double(sunrise))
    }
    
    func sunsetTime () -> String {
        return CommonUtility.sharedInstance.getTime(since1970: Double(sunset))
    }
}
