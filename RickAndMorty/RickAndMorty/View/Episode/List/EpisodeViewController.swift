//
//  EpisodeViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol IEpisodeUI: AnyObject {
    func update()
}

final class EpisodeViewController: UIViewController {
    
    var presenter: IEpisodePresenter
    private var episodeView = EpisodeView()
    private let searchController = UISearchController()
    
    init(presenter: IEpisodePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = episodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearch()
        setupView()
        episodeView.startIndicator()
        presenter.loadEpisodes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = episodeView.tableView.indexPathForSelectedRow {
            episodeView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupNavBar() {
        title = TextData.episodeTitleVC.rawValue
        navigationItem.searchController = searchController
    }
    
    private func setupView() {
        episodeView.tableView.delegate = self
        episodeView.tableView.dataSource = self
        episodeView.tableView.register(EpisodeViewCell.self, forCellReuseIdentifier: EpisodeViewCell.identifier)
    }
}

// MARK: - UI Update

extension EpisodeViewController: IEpisodeUI {
    func update() {
        DispatchQueue.main.async {
            self.episodeView.stopIndicator()
            self.episodeView.tableView.reloadData()
        }
    }
}

// MARK: - Table Delegate

extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
}

// MARK: - Table Data Source

extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeViewCell.identifier, for: indexPath) as? EpisodeViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        
        let episode = presenter.episodes[indexPath.row]
        cell.configure(with: episode.name)
        
        return cell
    }
}

// MARK: - Search Delegate

extension EpisodeViewController: UISearchBarDelegate {
    private func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search the Episode"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.fetchEpisodesFromDB()
        } else {
            presenter.searchEpisodes(with: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.fetchEpisodesFromDB()
    }
}
