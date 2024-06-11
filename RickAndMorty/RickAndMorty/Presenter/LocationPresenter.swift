//
//  LocationPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

protocol ILocationPresenter {
    func loadLocations()
}

final class LocationPresenter: ILocationPresenter {
    weak var ui: ILocationUI?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    
    init(ui: ILocationUI?, networkService: INetworkService, databaseService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func loadLocations() {
        networkService.fetchLocations { [weak self] result in
            switch result {
            case .success(let locations):
                self?.databaseService.saveLocations(locations)
                self?.fetchLocationsFromRealm()
            case .failure(let error):
                print("Failed to fetch locations: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchLocationsFromRealm() {
        let realm = try! Realm()
        let locations = realm.objects(LocationEntity.self)
        ui?.update(with: Array(locations))
    }
}
