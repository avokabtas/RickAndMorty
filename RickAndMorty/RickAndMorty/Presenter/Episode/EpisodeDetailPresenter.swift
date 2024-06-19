//
//  EpisodeDetailPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import Foundation
import RealmSwift
import UIKit.UIImage

protocol IEpisodeDetailPresenter: AnyObject {
    var episode: EpisodeEntity { get }
    var episodeName: String { get }
    var episodenInfo: [(title: String, value: String)] { get }
    var characterCount: Int { get }
    func didLoad(ui: IEpisodeDetailUI)
    func getCharacters(at index: Int) -> CharacterEntity
    func getCharacterInfo(for character: CharacterEntity) -> (image: UIImage?, name: String, status: String)
}

final class EpisodeDetailPresenter: IEpisodeDetailPresenter {
    private weak var ui: IEpisodeDetailUI?
    var episode: EpisodeEntity
    
    init(episode: EpisodeEntity) {
        self.episode = episode
    }
    
    func didLoad(ui: IEpisodeDetailUI) {
        self.ui = ui
    }
    
    var episodeName: String {
        return episode.name
    }
    
    var episodenInfo: [(title: String, value: String)] {
        return [
            ("Air Date:", episode.airDate),
            ("Episode:", episode.episode),
            ("Number of characters:", String(episode.characters.count))
        ]
    }
    
    var characterCount: Int {
        return episode.characters.count
    }
       
    func getCharacters(at index: Int) -> CharacterEntity {
        let characterURL = episode.characters[index]

        guard let characterIDString = characterURL.components(separatedBy: "/").last,
              let characterID = Int(characterIDString) else {
            return CharacterEntity()
        }
        
        guard let realm = try? Realm(),
              let character = realm.object(ofType: CharacterEntity.self, forPrimaryKey: characterID) else {
            return CharacterEntity()
        }
        
        return character
    }
    
    func getCharacterInfo(for character: CharacterEntity) -> (image: UIImage?, name: String, status: String) {
        return CharacterFormatter.getFormattedCharacterInfo(for: character)
    }
}
