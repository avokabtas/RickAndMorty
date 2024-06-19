//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol ICharacterUI: AnyObject {
    func update()
}

final class CharacterViewController: UIViewController {
    
    private var presenter: ICharacterPresenter
    private var characterView = CharacterView()
    private let searchController = UISearchController()
    
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
        presenter.didLoad(ui: self)
        setupNavBar()
        setupSearch()
        setupView()
        changeSegmentControl()
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
        title = TextData.titleCharacters.rawValue
        NavigationBar().setupColor(for: self)
        navigationItem.searchController = searchController
        setupScrollToTopButton(for: characterView.tableView)
    }
    
    private func setupView() {
        characterView.tableView.delegate = self
        characterView.tableView.dataSource = self
        characterView.tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identifier)
    }
    
    private func changeSegmentControl() {
        characterView.statusSegmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            presenter.filterCharacters(by: .alive)
        case 2:
            presenter.filterCharacters(by: .dead)
        case 3:
            presenter.filterCharacters(by: .unknown)
        default:
            presenter.fetchCharactersFromDB()
        }
    }
}

// MARK: - UI Update

extension CharacterViewController: ICharacterUI {
    func update() {
        DispatchQueue.main.async {
            self.characterView.stopIndicator()
            self.characterView.tableView.reloadData()
        }
    }
}

// MARK: - Table Delegate

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Table.characterHeightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = presenter.characters[indexPath.row]
        let detailVC = Assembly.createCharacterDetailModule(with: character)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Table Data Source

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier, for: indexPath)
                as? CharacterViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        
        let character = presenter.characters[indexPath.row]
        let info = presenter.getCharacterInfo(for: character)
        cell.configure(with: info.image, name: info.name, status: info.status)
                
        return cell
    }
}

// MARK: - Search Delegate

extension CharacterViewController: UISearchBarDelegate {
    private func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = TextData.searchCharacter.rawValue
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
