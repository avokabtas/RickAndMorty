//
//  LocationEntity.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import RealmSwift

class LocationEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String
    @Persisted var type: String
    @Persisted var dimension: String
    @Persisted var residents: List<String>
    @Persisted var url: String
    @Persisted var created: String
}
