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

final class CharacterPresenter: ICharacterPresenter {
    weak var ui: ICharacterUI?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    
    init(ui: ICharacterUI?, networkService: INetworkService, databaseService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func loadCharacters() {
        networkService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.databaseService.saveCharacters(characters)
                self?.fetchCharactersFromRealm()
            case .failure(let error):
                print(DatabaseError.fetchError(error.localizedDescription))
            }
        }
    }
    
    private func fetchCharactersFromRealm() {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let characters = realm.objects(CharacterEntity.self)
                self.ui?.update(with: Array(characters))
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
}
