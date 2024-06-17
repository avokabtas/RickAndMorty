//
//  LocationPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

protocol ILocationPresenter {
    var locations: [LocationEntity] { get }
    func didLoad(ui: ILocationUI)
    func loadLocations()
    func searchLocations(with name: String)
    func fetchLocationsFromDB()
    func getFormattedLocationInfo(for location: LocationEntity) -> (name: String, type: String)
}

final class LocationPresenter: ILocationPresenter {
    weak var ui: ILocationUI?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    private(set) var locations: [LocationEntity] = []
    
    init(ui: ILocationUI?, networkService: INetworkService, databaseService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func didLoad(ui: ILocationUI) {
        self.ui = ui
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
            guard let realm = try? Realm() else {
                print(DatabaseError.notInitialized)
                return
            }
            let locations = realm.objects(LocationEntity.self)
                .filter("name CONTAINS[c] %@", name)
            self.locations = Array(locations)
            self.ui?.update()
        }
    }
    
    func fetchLocationsFromDB() {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else {
                print(DatabaseError.notInitialized)
                return
            }
            let locations = realm.objects(LocationEntity.self)
            self.locations = Array(locations)
            self.ui?.update()
        }
    }
    
    func getFormattedLocationInfo(for location: LocationEntity) -> (name: String, type: String) {
        return (name: location.name, type: location.type)
    }
}
