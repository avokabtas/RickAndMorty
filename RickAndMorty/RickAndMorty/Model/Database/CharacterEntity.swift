//
//  CharacterEntity.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import RealmSwift

class CharacterEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var status: String
    @Persisted var species: String
    @Persisted var type: String
    @Persisted var gender: String
    @Persisted var originName: String
    @Persisted var originUrl: String
    @Persisted var locationName: String
    @Persisted var locationUrl: String
    @Persisted var image: String
    @Persisted var url: String
    @Persisted var created: String
    @Persisted var episodes: List<String>
}
