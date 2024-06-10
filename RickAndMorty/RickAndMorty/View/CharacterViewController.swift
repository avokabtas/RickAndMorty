//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

final class CharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        //navigationItem.title = TextData.characterTitleVC.rawValue
        title = TextData.characterTitleVC.rawValue
    }



}

