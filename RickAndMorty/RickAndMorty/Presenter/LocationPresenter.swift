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
    func searchLocations(with name: String)
    func fetchLocationsFromDB()
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
                self?.fetchLocationsFromDB()
            case .failure(let error):
                print(DatabaseError.fetchError(error.localizedDescription))
                self?.fetchLocationsFromDB()
            }
        }
    }
    
    func searchLocations(with name: String) {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let locations = realm.objects(LocationEntity.self)
                    .filter("name CONTAINS[c] %@", name)
                self.ui?.update(with: Array(locations))
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
    
    func fetchLocationsFromDB() {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let locations = realm.objects(LocationEntity.self)
                self.ui?.update(with: Array(locations))
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
}
