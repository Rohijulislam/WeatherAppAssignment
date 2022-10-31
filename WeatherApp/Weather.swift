//
//  Weather.swift
//  WeatherApp
//
//  Created by Md. Rohejul Islam on 30/10/22.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    
    func getIconURL() -> URL? {
        debugPrint(Constants.WEATHER_ICON_BASE_URL + icon + Constants.WEATHER_ICON_TYPE)
        return URL(string: Constants.WEATHER_ICON_BASE_URL + icon + Constants.WEATHER_ICON_TYPE)
    }
}
