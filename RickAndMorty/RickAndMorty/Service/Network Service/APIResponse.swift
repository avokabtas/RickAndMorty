//
//  APIResponse.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation

/// Структура для общего ответа API
struct APIResponse<T: Decodable>: Decodable {
    let results: [T]
}
