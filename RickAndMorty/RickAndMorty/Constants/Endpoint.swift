//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation

/// Получить доступ к списку, используя конечную точку /character, /location, /episode в API
enum Endpoint: String {
    case character
    case location
    case episode
}
