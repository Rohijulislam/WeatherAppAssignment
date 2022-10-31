//
//  ForecastList.swift
//  WeatherApp
//
//  Created by Md. Rohejul Islam on 30/10/22.
//

import Foundation

// MARK: - ForecastList
struct Forecast: Codable {
    let dt: Int
    let main: ForecastInfo
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop
        case dtTxt = "dt_txt"
    }
    
    func getDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(dt))
    }
}
