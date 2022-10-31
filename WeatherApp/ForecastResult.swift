//
//  ForecastReulst.swift
//  WeatherApp
//
//  Created by Md. Rohejul Islam on 30/10/22.
//

import Foundation

// MARK: - ForecastResult
struct ForecastResult: Codable {
    let cod: String
    let message, cnt: Int
    let list: [Forecast]
    let city: City
    
    func sortedForecastsByDays() -> [[Forecast]] {
        var groupedData = [[Forecast]] ()
        guard var prevDate = list.first?.getDate() else { return [[]] }
        
        groupedData.append([])
        var idx = 0
        for item in list {
            if item.getDate().get(.day) != prevDate.get(.day) {
                idx += 1
                prevDate = item.getDate()
                groupedData.append([])
            }
            groupedData[idx].append(item)
        }
        
        return groupedData
    }
}
