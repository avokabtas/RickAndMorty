//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case invalidJSON
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL!"
        case .invalidResponse:
            return "Invalid response or status code!"
        case .noData:
            return "No data received!"
        case .invalidJSON:
            return "Error parsing JSON!"
        case .custom(let message):
            return message
        }
    }
}
