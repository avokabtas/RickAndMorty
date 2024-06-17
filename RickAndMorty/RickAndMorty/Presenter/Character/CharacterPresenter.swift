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
    func filterCharacters(by status: Status?)
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
            guard let realm = try? Realm() else {
                print(DatabaseError.notInitialized)
                return
            }
            let characters = realm.objects(CharacterEntity.self)
                .filter("name CONTAINS[c] %@", name)
            self.characters = Array(characters)
            self.ui?.update()
        }
    }
    
    func fetchCharactersFromDB() {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else {
                print(DatabaseError.notInitialized)
                return
            }
            let characters = realm.objects(CharacterEntity.self)
            self.characters = Array(characters)
            self.ui?.update()
        }
    }

    func filterCharacters(by status: Status?) {
        DispatchQueue.main.async {
            guard let realm = try? Realm() else {
                print(DatabaseError.notInitialized)
                return
            }
            let characters: Results<CharacterEntity>
            switch status {
            case .unknown:
                characters = realm.objects(CharacterEntity.self).filter("status = 'unknown'")
            case .alive:
                characters = realm.objects(CharacterEntity.self).filter("status = 'Alive'")
            case .dead:
                characters = realm.objects(CharacterEntity.self).filter("status = 'Dead'")
            default:
                characters = realm.objects(CharacterEntity.self)
            }
            self.characters = Array(characters)
            self.ui?.update()
        }
    }
}
