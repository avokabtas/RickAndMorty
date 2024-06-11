//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

protocol ICharacterPresenter: AnyObject {
    func loadCharacters()
}

class CharacterPresenter: ICharacterPresenter {
    weak var ui: ICharacterUI?
    private let networkService: INetworkService
    private let realmService: IDatabaseService
    
    init(ui: ICharacterUI?, networkService: INetworkService, realmService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.realmService = realmService
    }
    
    func loadCharacters() {
        networkService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.realmService.saveCharacters(characters)
                self?.fetchCharactersFromRealm()
            case .failure(let error):
                print("Failed to fetch characters: \(error.localizedDescription)")
            }
        }
    }
    
    private func fetchCharactersFromRealm() {
        let realm = try! Realm()
        let characters = realm.objects(CharacterEntity.self)
        ui?.update(with: Array(characters))
    }
}
