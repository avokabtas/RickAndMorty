//
//  NavigationBar.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 17.06.2024.
//

import Foundation
import UIKit

struct NavigationBar {
    /// Устанавливаем цвет заголовка с учетом светлой и темной темы
    func setupColor(for viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else { return }
        
        let labelColor = Color.mainTitleNavBar
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: labelColor]
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: labelColor]
    }
}
