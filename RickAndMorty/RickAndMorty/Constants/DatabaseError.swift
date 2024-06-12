//
//  DatabaseError.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 12.06.2024.
//

import Foundation

enum DatabaseError: Error {
    case notInitialized
    case saveError(String)
    case fetchError(String)
    
    var localizedDescription: String {
        switch self {
        case .notInitialized:
            return "Error initializing Realm"
        case .saveError(let message):
            return "Error saving data: \(message)"
        case .fetchError(let message):
            return "Error fetching data: \(message)"
        }
    }
}
