//
//  LocationDetailPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import Foundation
import RealmSwift
import UIKit.UIImage

protocol ILocationDetailPresenter: AnyObject {
    var location: LocationEntity { get }
    var locationName: String { get }
    var locationInfo: [(title: String, value: String)] { get }
    var residentCount: Int { get }
    func didLoad(ui: ILocationDetailUI)
    func getResidents(at index: Int) -> CharacterEntity
    func getCharacterInfo(for character: CharacterEntity) -> (image: UIImage?, name: String, status: String)
}

final class LocationDetailPresenter: ILocationDetailPresenter {
    private weak var ui: ILocationDetailUI?
    let location: LocationEntity
    
    init(location: LocationEntity) {
        self.location = location
    }
    
    func didLoad(ui: ILocationDetailUI) {
        self.ui = ui
    }
    
    var locationName: String {
        return location.name
    }
    
    var locationInfo: [(title: String, value: String)] {
        return [
            ("Type:", location.type.isEmpty ? "unknown" : location.type),
            ("Dimension:", location.dimension.isEmpty ? "unknown" : location.dimension),
            ("Number of residents:", String(location.residents.count))
        ]
    }
    
    var residentCount: Int {
        return location.residents.count
    }
       
    func getResidents(at index: Int) -> CharacterEntity {
        let residentURL = location.residents[index]

        guard let characterIDString = residentURL.components(separatedBy: "/").last,
              let characterID = Int(characterIDString) else {
            return CharacterEntity()
        }
        
        guard let realm = try? Realm(),
              let character = realm.object(ofType: CharacterEntity.self, forPrimaryKey: characterID) else {
            return CharacterEntity()
        }
        
        return character
    }
    
    func getCharacterInfo(for character: CharacterEntity) -> (image: UIImage?, name: String, status: String) {
        return CharacterFormatter.getFormattedCharacterInfo(for: character)
    }
}
