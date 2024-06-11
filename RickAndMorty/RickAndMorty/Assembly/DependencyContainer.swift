//
//  DependencyContainer.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

/// Внедрение зависимостей
final class DependencyContainer {
    static let shared = DependencyContainer()

    let networkService: NetworkService
    let databaseService: RealmService
    
    private init() {
        self.networkService = NetworkService()
        self.databaseService = RealmService.shared
    }
}
