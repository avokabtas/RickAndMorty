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
    var presenter: IEpisodePresenter
    
    init(presenter: IEpisodePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = TextData.episodeTitleVC.rawValue
        presenter.loadEpisodes()
    }
}

extension EpisodeViewController: IEpisodeUI {
    func update(with episodes: [EpisodeEntity]) {
        episodes.forEach { episode in
            print(episode.airDate)
        }
    }
}
