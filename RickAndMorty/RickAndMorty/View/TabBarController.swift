//
//  TabBarController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let characterVC = CharacterViewController()
        let locationVC = LocationViewController()
        let episodeVC = EpisodeViewController()
        
        characterVC.tabBarItem = UITabBarItem(title: TabBar.characterTitle,
                                              image: TabBar.characterIcon,
                                              selectedImage: nil)
        locationVC.tabBarItem = UITabBarItem(title: TabBar.locationTitle,
                                             image: TabBar.locationIcon,
                                             selectedImage: nil)
        episodeVC.tabBarItem = UITabBarItem(title: TabBar.episodeTitle,
                                            image: TabBar.episodeIcon,
                                            selectedImage: nil)
        
        self.viewControllers = [characterVC, locationVC, episodeVC]
    }
}
