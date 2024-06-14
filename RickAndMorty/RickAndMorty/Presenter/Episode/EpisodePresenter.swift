//
//  EpisodePresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

protocol IEpisodePresenter {
    var episodes: [EpisodeEntity] { get }
    func loadEpisodes()
    func searchEpisodes(with name: String)
    func fetchEpisodesFromDB()
}

final class EpisodePresenter: IEpisodePresenter {
    weak var ui: IEpisodeUI?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    private(set) var episodes: [EpisodeEntity] = []
    
    init(ui: IEpisodeUI?, networkService: INetworkService, databaseService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func loadEpisodes() {
        networkService.fetchEpisodes { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.databaseService.saveEpisodes(episodes)
                self?.fetchEpisodesFromDB()
            case .failure(let error):
                print(DatabaseError.fetchError(error.localizedDescription))
                self?.fetchEpisodesFromDB()
            }
        }
    }
    
    func searchEpisodes(with name: String) {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let episodes = realm.objects(EpisodeEntity.self)
                    .filter("name CONTAINS[c] %@", name)
                self.episodes = Array(episodes)
                self.ui?.update()
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
    
    func fetchEpisodesFromDB() {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let episodes = realm.objects(EpisodeEntity.self)
                self.episodes = Array(episodes)
                self.ui?.update()
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
}
