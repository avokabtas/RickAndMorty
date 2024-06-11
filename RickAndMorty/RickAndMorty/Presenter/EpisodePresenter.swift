//
//  EpisodePresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

protocol IEpisodePresenter {
    func loadEpisodes()
}

final class EpisodePresenter: IEpisodePresenter {
    weak var ui: IEpisodeUI?
    private let networkService: INetworkService
    private let realmService: IDatabaseService
    
    init(ui: IEpisodeUI?, networkService: INetworkService, databaseService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.realmService = databaseService
    }
    
    func loadEpisodes() {
        networkService.fetchEpisodes { [weak self] result in
            switch result {
            case .success(let episodes):
                self?.realmService.saveEpisodes(episodes)
                self?.fetchEpisodesFromRealm()
            case .failure(let error):
                print("Failed to fetch episodes: \(error.localizedDescription)")
                self?.fetchEpisodesFromRealm()
            }
        }
    }
    
    private func fetchEpisodesFromRealm() {
        let realm = try! Realm()
        let episodes = realm.objects(EpisodeEntity.self)
        ui?.update(with: Array(episodes))
    }
    
}
