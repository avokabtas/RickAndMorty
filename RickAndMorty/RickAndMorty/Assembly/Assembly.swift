//
//  Assembly.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 10.06.2024.
//

import Foundation
import UIKit

class Assembly {
    static func createCharacterModule() -> UIViewController {
        let networkService = NetworkService()
        let realmService = RealmService.shared
        let presenter = CharacterPresenter(ui: nil, networkService: networkService, realmService: realmService)
        let viewController = CharacterViewController(presenter: presenter)
        presenter.ui = viewController
        return viewController
    }
    
//    static func createLocationModule() -> UIViewController {
//        let ui = LocationViewController()
//        let presenter = LocationPresenter(ui: ui)
//        ui.presenter = presenter
//        return ui
//    }
//    
//    static func createEpisodeModule() -> UIViewController {
//        let ui = EpisodeViewController()
//        let presenter = EpisodePresenter(ui: ui)
//        ui.presenter = presenter
//        return ui
//    }
}
