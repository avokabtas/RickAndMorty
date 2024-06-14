//
//  Character.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Origin
    let location: SingleLocation
    let image: String
    var imageData: Data?
    let episode: [String]
    let url: String
    let created: String
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Gender: String, Decodable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct SingleLocation: Codable {
    let name: String
    let url: String
}