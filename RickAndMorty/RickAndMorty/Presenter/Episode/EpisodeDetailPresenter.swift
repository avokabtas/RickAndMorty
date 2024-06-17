//
//  EpisodeDetailPresenter.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import Foundation

protocol IEpisodeDetailPresenter: AnyObject {
    var episode: EpisodeEntity { get }
    var episodeName: String { get }
    var episodenInfo: [(title: String, value: String)] { get }
    func didLoad(ui: IEpisodeDetailUI)
}

final class EpisodeDetailPresenter: IEpisodeDetailPresenter {
    private weak var ui: IEpisodeDetailUI?
    var episode: EpisodeEntity
    
    init(episode: EpisodeEntity) {
        self.episode = episode
    }
    
    func didLoad(ui: IEpisodeDetailUI) {
        self.ui = ui
    }
    
    var episodeName: String {
        return episode.name
    }
    
    var episodenInfo: [(title: String, value: String)] {
        return [
            ("Air Date:", episode.airDate),
            ("Episode:", episode.episode),
            ("Number of characters:", String(episode.characters.count))
        ]
    }
}
