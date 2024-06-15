//
//  Assembly.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import UIKit

/// Сборщик для создания модулей
enum Assembly {
    
    // MARK: - Main Module
    
    static func createCharacterModule() -> UIViewController {
        let networkService = DependencyContainer.shared.networkService
        let databaseService = DependencyContainer.shared.databaseService
        let presenter = CharacterPresenter(ui: nil, networkService: networkService, databaseService: databaseService)
        let viewController = CharacterViewController(presenter: presenter)
        return viewController
    }
    
    static func createLocationModule() -> UIViewController {
        let networkService = DependencyContainer.shared.networkService
        let databaseService = DependencyContainer.shared.databaseService
        let presenter = LocationPresenter(ui: nil, networkService: networkService, databaseService: databaseService)
        let viewController = LocationViewController(presenter: presenter)
        return viewController
    }
   
    static func createEpisodeModule() -> UIViewController {
        let networkService = DependencyContainer.shared.networkService
        let databaseService = DependencyContainer.shared.databaseService
        let presenter = EpisodePresenter(ui: nil, networkService: networkService, databaseService: databaseService)
        let viewController = EpisodeViewController(presenter: presenter)
        return viewController
    }
    
    // MARK: - Detail Module
    
    static func createCharacterDetailModule(with character: CharacterEntity) -> UIViewController {
        let presenter = CharacterDetailPresenter(character: character)
        let viewController = CharacterDetailViewController(presenter: presenter)
        return viewController
    }
    
    static func createLocationDetailModule(with location: LocationEntity) -> UIViewController {
        let presenter = LocationDetailPresenter(location: location)
        let viewController = LocationDetailViewController(presenter: presenter)
        return viewController
    }
    
    static func createEpisodeDetailModule(with episode: EpisodeEntity) -> UIViewController {
        let presenter = EpisodeDetailPresenter(episode: episode)
        let viewController = EpisodeDetailViewController(presenter: presenter)
        return viewController
    }
}
