//
//  LocationDetailPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import Foundation

protocol ILocationDetailPresenter: AnyObject {
    var location: LocationEntity { get }
    var locationName: String { get }
    var locationInfo: [(title: String, value: String)] { get }
    func didLoad(ui: ILocationDetailUI)
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
}
