//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 11.06.2024.
//

import Foundation
import RealmSwift

protocol ICharacterPresenter: AnyObject {
    var characters: [CharacterEntity] { get }
    func didLoad(ui: ICharacterUI)
    func loadCharacters()
    func searchCharacters(with name: String)
    func fetchCharactersFromDB()
}

final class CharacterPresenter: ICharacterPresenter {
    weak var ui: ICharacterUI?
    private let networkService: INetworkService
    private let databaseService: IDatabaseService
    private(set) var characters: [CharacterEntity] = []
    
    init(ui: ICharacterUI?, networkService: INetworkService, databaseService: IDatabaseService) {
        self.ui = ui
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func didLoad(ui: ICharacterUI) {
        self.ui = ui
    }
    
    func loadCharacters() {
        networkService.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.databaseService.saveCharacters(characters)
                self?.fetchCharactersFromDB()
            case .failure(let error):
                print(DatabaseError.fetchError(error.localizedDescription))
                self?.fetchCharactersFromDB()
            }
        }
    }
    
    func searchCharacters(with name: String) {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let characters = realm.objects(CharacterEntity.self)
                    .filter("name CONTAINS[c] %@", name)
                self.characters = Array(characters)
                self.ui?.update()
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
    
    func fetchCharactersFromDB() {
        DispatchQueue.main.async {
            if let realm = try? Realm() {
                let characters = realm.objects(CharacterEntity.self)
                self.characters = Array(characters)
                self.ui?.update()
            } else {
                print(DatabaseError.notInitialized)
            }
        }
    }
}
