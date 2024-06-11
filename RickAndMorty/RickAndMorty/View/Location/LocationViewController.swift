//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol ILocationUI: AnyObject {
    func update(with locations: [LocationEntity])
}

final class LocationViewController: UIViewController {
    
    var presenter: ILocationPresenter
    
    init(presenter: ILocationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = TextData.locationTitleVC.rawValue
        presenter.loadLocations()
        
    }
    

}

extension LocationViewController: ILocationUI {
    func update(with locations: [LocationEntity]) {
        locations.forEach { location in
            print(location.name)
        }
    }
}
