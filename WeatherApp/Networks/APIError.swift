//
//  APIError.swift
//  WeatherApp
//
//  Created by Md. Rohejul Islam on 30/10/22.
//

import Foundation

enum APIError: Error {
    
    case invalidURL(urlString : String)
    case invalidData
    case requestFailed
    case jsonConversionFailure
    case jsonParsingFailure
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
        case .invalidData:
            return "Invalid Data"
        case .requestFailed:
            return "Request Failed. Check your internet connection & try again."
        case .jsonConversionFailure:
            return "JSON Conversion Failure"
        case .jsonParsingFailure:
            return "JSON Parsing Failure"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        case .invalidURL(urlString: let urlString):
            return urlString
        }
    }
}
