//
//  EpisodeEntity.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import RealmSwift

class EpisodeEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var airDate: String
    @Persisted var episode: String
    @Persisted var characters: List<String>
    @Persisted var url: String
    @Persisted var created: String
}
