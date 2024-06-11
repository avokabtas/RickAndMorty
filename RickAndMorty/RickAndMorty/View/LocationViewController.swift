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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        //navigationItem.title = TextData.locationTitleVC.rawValue
        title = TextData.locationTitleVC.rawValue
        
    }
    

}
