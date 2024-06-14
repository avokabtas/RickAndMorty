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
    static func createCharacterModule() -> UIViewController {
        let networkService = DependencyContainer.shared.networkService
        let databaseService = DependencyContainer.shared.databaseService
        let presenter = CharacterPresenter(ui: nil, networkService: networkService, databaseService: databaseService)
        let viewController = CharacterViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
    
    static func createLocationModule() -> UIViewController {
        let networkService = DependencyContainer.shared.networkService
        let databaseService = DependencyContainer.shared.databaseService
        let presenter = LocationPresenter(ui: nil, networkService: networkService, databaseService: databaseService)
        let viewController = LocationViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
   
    static func createEpisodeModule() -> UIViewController {
        let networkService = DependencyContainer.shared.networkService
        let databaseService = DependencyContainer.shared.databaseService
        let presenter = EpisodePresenter(ui: nil, networkService: networkService, databaseService: databaseService)
        let viewController = EpisodeViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
    
    static func createCharacterDetailModule(with character: CharacterEntity) -> UIViewController {
        let presenter = CharacterDetailPresenter(character: character)
        let viewController = CharacterDetailViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
}
