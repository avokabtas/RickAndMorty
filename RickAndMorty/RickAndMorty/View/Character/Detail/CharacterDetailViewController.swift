//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import UIKit

protocol ICharacterDetailUI: AnyObject {
    func update()
}

final class CharacterDetailViewController: UIViewController {
    
    private var characterDetailView = CharacterDetailView()
    private var presenter: ICharacterDetailPresenter
    
    init(presenter: ICharacterDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = characterDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitle()
        setupView()
    }
    
    private func setupTitle() {
        //title = presenter.characterName
        
        let titleLabel = UILabel()
        titleLabel.text = presenter.characterName
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel
    }
    
    private func setupView() {
        
        characterDetailView.tableView.dataSource = self
        characterDetailView.tableView.register(CharacterDetailViewCell.self, forCellReuseIdentifier: CharacterDetailViewCell.identifier)
        
//        if let imageData = presenter.character.imageData {
//            characterDetailView.characterImageView.image = UIImage(data: imageData)
//        }
        if let characterImage = presenter.characterImage {
            characterDetailView.characterImageView.image = characterImage
        }
    }
}

extension CharacterDetailViewController: ICharacterDetailUI {
    func update() {
        DispatchQueue.main.async {
            self.characterDetailView.tableView.reloadData()
        }
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characterInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailViewCell.identifier, for: indexPath) as! CharacterDetailViewCell
        let info = presenter.characterInfo[indexPath.row]
        cell.configure(title: info.title, value: info.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Info"
    }
}
