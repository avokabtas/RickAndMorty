//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let characterVC = CharacterViewController()
        let locationVC = LocationViewController()
        let episodeVC = EpisodeViewController()

        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic

        let navigationCharacter = UINavigationController(rootViewController: characterVC)
        let navigationLocation = UINavigationController(rootViewController: locationVC)
        let navigationEpisode = UINavigationController(rootViewController: episodeVC)

        navigationCharacter.tabBarItem = UITabBarItem(title: TabBar.characterTitle,
                                                      image: TabBar.characterIcon,
                                                      tag: 1)
        navigationLocation.tabBarItem = UITabBarItem(title: TabBar.locationTitle,
                                                     image: TabBar.locationIcon,
                                                     tag: 2)
        navigationEpisode.tabBarItem = UITabBarItem(title: TabBar.episodeTitle,
                                                    image: TabBar.episodeIcon,
                                                    tag: 3)
        
        let navigations = [navigationCharacter, navigationLocation, navigationEpisode]
        
        navigations.forEach { navigation in
            navigation.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(navigations, animated: true)
    }
}
