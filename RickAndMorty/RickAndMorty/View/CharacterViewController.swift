//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol ICharacterUI: AnyObject {
    func update(with characters: [CharacterEntity])
}

final class CharacterViewController: UIViewController {
    
    let network = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        //navigationItem.title = TextData.characterTitleVC.rawValue
        title = TextData.characterTitleVC.rawValue
        
        network.fetchCharacters { result in
            switch result {
            case .success(let characters):
                print("fetchCharacters")
                for character in characters {
                    print("Character: \(character.name), Status: \(character.status), Species: \(character.species), Gender: \(character.gender)")
                }
            case .failure(let error):
                print("Failed to fetch characters: \(error.localizedDescription)")
            }
        }
        
        network.fetchLocations { result in
            switch result {
            case .success(let locations):
                print("fetchLocations")
                for location in locations {
                    print("Location: \(location.name), Type: \(location.type), Dimension: \(location.dimension)")
                }
            case .failure(let error):
                print("Failed to fetch locations: \(error.localizedDescription)")
            }
        }
        
        network.fetchEpisodes { result in
            switch result {
            case .success(let episodes):
                print("fetchEpisodes")
                for episode in episodes {
                    print("Episode: \(episode.name), Air Date: \(episode.air_date), Episode: \(episode.episode)")
                }
            case .failure(let error):
                print("Failed to fetch episodes: \(error.localizedDescription)")
            }
        }
        
    }


}

