//
//  EpisodeViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol IEpisodeUI: AnyObject {
    func update(with episodes: [EpisodeEntity])
}

final class EpisodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .orange
        //navigationItem.title = TextData.episodeTitleVC.rawValue
        title = TextData.episodeTitleVC.rawValue
    }
    


}
