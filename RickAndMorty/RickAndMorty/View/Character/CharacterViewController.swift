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
    
    private var presenter: ICharacterPresenter
    private var characterView = CharacterView()
    private let searchController = UISearchController()
    private var characters: [CharacterEntity] = []
    
    init(presenter: ICharacterPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = characterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearch()
        setupView()
        characterView.startIndicator()
        presenter.loadCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = characterView.tableView.indexPathForSelectedRow {
            characterView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupNavBar() {
        title = TextData.characterTitleVC.rawValue
        navigationItem.searchController = searchController
    }
    
    private func setupView() {
        characterView.tableView.delegate = self
        characterView.tableView.dataSource = self
        characterView.tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identifier)
    }
}

// MARK: - UI Update

extension CharacterViewController: ICharacterUI {
    func update(with characters: [CharacterEntity]) {
        self.characters = characters
        DispatchQueue.main.async {
            self.characterView.stopIndicator()
            self.characterView.tableView.reloadData()
        }
    }
}

// MARK: - Table Delegate

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let character = characters[indexPath.row]
    //        let detailVC = CharacterDetailView(character: character)
    //        navigationController?.pushViewController(detailVC, animated: true)
    //    }
}

// MARK: - Table Data Source

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier, for: indexPath)
                as? CharacterViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        
        let character = characters[indexPath.row]
        
        if let imageData = character.imageData, let image = UIImage(data: imageData) {
            cell.configure(with: image, with: character.name)
        } else {
            cell.configure(with: nil, with: character.name)
        }
        
        return cell
    }
}

// MARK: - Search Delegate

extension CharacterViewController: UISearchBarDelegate {
    private func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search the Сharacter"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.fetchCharactersFromDB()
        } else {
            presenter.searchCharacters(with: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.fetchCharactersFromDB()
    }
}
