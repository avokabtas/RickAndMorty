//
//  EpisodeDetailViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import UIKit

protocol IEpisodeDetailUI: AnyObject {
    func update()
}

final class EpisodeDetailViewController: UIViewController {
    
    private var episodeDetailView = EpisodeDetailView()
    private var presenter: IEpisodeDetailPresenter
    
    init(presenter: IEpisodeDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = episodeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad(ui: self)
        setupTitle()
        setupView()
    }
    
    private func setupTitle() {
        title = presenter.episodeName
    }
    
    private func setupView() {
        episodeDetailView.tableView.dataSource = self
        episodeDetailView.tableView.delegate = self
        episodeDetailView.tableView.register(EpisodeInfoViewCell.self, forCellReuseIdentifier: EpisodeInfoViewCell.identifier)
        episodeDetailView.tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identifier)
    }
}

// MARK: - UI Update

extension EpisodeDetailViewController: IEpisodeDetailUI {
    func update() {
        DispatchQueue.main.async {
            self.episodeDetailView.tableView.reloadData()
        }
    }
}

// MARK: - Table Data Source

extension EpisodeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter.episodenInfo.count
        } else {
            return presenter.characterCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return configureEpisodeInfoCell(at: indexPath, in: tableView)
        } else {
            return configureCharacterCell(at: indexPath, in: tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Table.infoSection
        } else {
            return Table.charactersSection
        }
    }
}

// MARK: - Table Delegate

extension EpisodeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 1 {
            let character = presenter.getCharacters(at: indexPath.row)
            navigationController?.pushViewController(Assembly.createCharacterDetailModule(with: character), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return Table.characterHeightCell
        } else {
            return UITableView.automaticDimension
        }
    }
}

// MARK: - Configure Cells

extension EpisodeDetailViewController {
    private func configureEpisodeInfoCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoViewCell.identifier,
                                                       for: indexPath) as? EpisodeInfoViewCell else {
            return UITableViewCell()
        }
        
        let info = presenter.episodenInfo[indexPath.row]
        cell.configure(with: info.title, with: info.value)
        
        return cell
    }
    
    private func configureCharacterCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier,
                                                       for: indexPath) as? CharacterViewCell else {
            return UITableViewCell()
        }
        
        let character = presenter.getCharacters(at: indexPath.row)
        let info = presenter.getCharacterInfo(for: character)
        cell.configure(with: info.image, name: info.name, status: info.status)
        
        return cell
    }
}
