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
        title = TextData.episodeTitleVC.rawValue
    }
    


}

extension EpisodeViewController: IEpisodeUI {
    func update(with episodes: [EpisodeEntity]) {
        
    }
}
