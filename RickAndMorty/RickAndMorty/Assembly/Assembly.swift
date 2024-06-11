//
//  Assembly.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import UIKit

enum Assembly {
    static func createCharacterModule() -> UIViewController {
        let networkService = NetworkService()
        let realmService = RealmService.shared
        let presenter = CharacterPresenter(ui: nil, networkService: networkService, databaseService: realmService)
        let viewController = CharacterViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
    
    static func createLocationModule() -> UIViewController {
        let networkService = NetworkService()
        let realmService = RealmService.shared
        let presenter = LocationPresenter(ui: nil, networkService: networkService, databaseService: realmService)
        let viewController = LocationViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
   
//    static func createEpisodeModule() -> UIViewController {
//        let networkService = NetworkService()
//        let realmService = RealmService.shared
//        let presenter = EpisodePresenter(ui: nil, networkService: networkService, databaseService: realmService)
//        let viewController = EpisodeViewController(presenter: presenter)
//        presenter.ui = viewController
//        return viewController
//    }
}
