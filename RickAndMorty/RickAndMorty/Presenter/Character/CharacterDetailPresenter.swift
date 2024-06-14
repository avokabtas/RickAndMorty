//
//  CharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import Foundation
import UIKit.UIImage

protocol ICharacterDetailPresenter: AnyObject {
    var character: CharacterEntity { get }
    var characterName: String { get }
    var characterImage: UIImage? { get }
    var characterInfo: [(title: String, value: String)] { get }
}

final class CharacterDetailPresenter: ICharacterDetailPresenter {
    weak var ui: ICharacterDetailUI?
    let character: CharacterEntity
    
    init(character: CharacterEntity) {
        self.character = character
    }
    
    var characterName: String {
        return character.name
    }
    
    var characterImage: UIImage? {
        guard let imageData = character.imageData else { return nil }
        return UIImage(data: imageData)
    }
    
    var characterInfo: [(title: String, value: String)] {
        return [
            ("Status", character.status),
            ("Species", character.species),
            ("Type", character.type),
            ("Gender", character.gender),
            ("Origin", character.originName),
            ("Location", character.locationName),
        ]
    }
}
