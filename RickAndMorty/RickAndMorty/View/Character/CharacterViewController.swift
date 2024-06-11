//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol ICharacterUI: AnyObject {
    func update(with characters: [CharacterEntity])
}

final class CharacterViewController: UIViewController {
    
    var presenter: ICharacterPresenter
    
    init(presenter: ICharacterPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        title = TextData.characterTitleVC.rawValue
        presenter.loadCharacters()
    }

}

extension CharacterViewController: ICharacterUI {
    func update(with characters: [CharacterEntity]) {
        characters.forEach { character in
            print(character.name)
        }
    }
}
