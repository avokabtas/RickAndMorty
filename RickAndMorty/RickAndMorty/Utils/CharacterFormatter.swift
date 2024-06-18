//
//  CharacterFormatter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 18.06.2024.
//

import Foundation
import UIKit.UIImage

class CharacterFormatter {
    static func getFormattedCharacterInfo(for character: CharacterEntity) -> (image: UIImage?, name: String, status: String) {
        if let imageData = character.imageData, let image = UIImage(data: imageData) {
            return (image: image, name: character.name, status: character.status)
        } else {
            return (image: Icon.defaultImage, name: character.name, status: character.status)
        }
    }
}
