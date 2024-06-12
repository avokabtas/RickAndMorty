//
//  RealmService.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import RealmSwift

protocol IDatabaseService: AnyObject {
    func saveCharacters(_ characters: [Character])
    func saveLocations(_ locations: [Location])
    func saveEpisodes(_ episodes: [Episode])
}

final class RealmService: IDatabaseService {
    static let shared = RealmService()
    
    private init() {}
    
    func saveCharacters(_ characters: [Character]) {
        do {
            let realm = try Realm()
            let entities = characters.map { character -> CharacterEntity in
                let entity = CharacterEntity()
                entity.id = character.id
                entity.name = character.name
                entity.status = character.status.rawValue
                entity.species = character.species
                entity.type = character.type
                entity.gender = character.gender.rawValue
                entity.originName = character.origin.name
                entity.originUrl = character.origin.url
                entity.locationName = character.location.name
                entity.locationUrl = character.location.url
                entity.image = character.image
                entity.imageData = character.imageData
                entity.url = character.url
                entity.created = character.created
                entity.episodes.append(objectsIn: character.episode)
                return entity
            }
            try realm.write {
                realm.add(entities, update: .modified)
            }
        } catch {
            print(DatabaseError.saveError(error.localizedDescription))
        }
    }
    
    func saveLocations(_ locations: [Location]) {
        do {
            let realm = try Realm()
            let entities = locations.map { location -> LocationEntity in
                let entity = LocationEntity()
                entity.id = location.id
                entity.name = location.name
                entity.type = location.type
                entity.dimension = location.dimension
                entity.url = location.url
                entity.created = location.created
                entity.residents.append(objectsIn: location.residents)
                return entity
            }
            try realm.write {
                realm.add(entities, update: .modified)
            }
        } catch {
            print(DatabaseError.saveError(error.localizedDescription))
        }
    }
    
    func saveEpisodes(_ episodes: [Episode]) {
        do {
            let realm = try! Realm()
            let entities = episodes.map { episode -> EpisodeEntity in
                let entity = EpisodeEntity()
                entity.id = episode.id
                entity.name = episode.name
                entity.airDate = episode.airDate
                entity.episode = episode.episode
                entity.url = episode.url
                entity.created = episode.created
                entity.characters.append(objectsIn: episode.characters)
                return entity
            }
            try realm.write {
                realm.add(entities, update: .modified)
            }
        } catch {
            print(DatabaseError.saveError(error.localizedDescription))
        }
    }
}
