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
        presenter.didLoad(ui: self)
        setupTitle()
        setupView()
    }
    
    private func setupTitle() {
        title = presenter.characterName
    }
    
    private func setupView() {
        // Настройка для поддержки динамической высоты ячеек
        characterDetailView.tableView.rowHeight = UITableView.automaticDimension
        characterDetailView.tableView.dataSource = self
        characterDetailView.tableView.delegate = self
        characterDetailView.tableView.register(CharacterInfoViewCell.self, 
                                               forCellReuseIdentifier: CharacterInfoViewCell.identifier)
        characterDetailView.tableView.register(CharacterImageViewCell.self, 
                                               forCellReuseIdentifier: CharacterImageViewCell.identifier)
    }
}

// MARK: - UI Update

extension CharacterDetailViewController: ICharacterDetailUI {
    func update() {
        DispatchQueue.main.async {
            self.characterDetailView.tableView.reloadData()
        }
    }
}

// MARK: - Table Data Source

extension CharacterDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return presenter.characterInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterImageViewCell.identifier, 
                                                           for: indexPath) as? CharacterImageViewCell else {
                return UITableViewCell()
            }
            if let characterImage = presenter.characterImage {
                cell.configure(with: characterImage)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoViewCell.identifier, 
                                                           for: indexPath) as? CharacterInfoViewCell else {
                return UITableViewCell()
            }
            let info = presenter.characterInfo[indexPath.row]
            cell.configure(with: info.title, with: info.value)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Info"
        }
        return nil
    }
}

// MARK: - Table Delegate

extension CharacterDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
