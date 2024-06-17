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
        episodeDetailView.tableView.register(EpisodeInfoViewCell.self,
                                               forCellReuseIdentifier: EpisodeInfoViewCell.identifier)
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.episodenInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoViewCell.identifier,
                                                       for: indexPath) as? EpisodeInfoViewCell else {
            return UITableViewCell()
        }
        let info = presenter.episodenInfo[indexPath.row]
        cell.configure(with: info.title, with: info.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Table.infoSection
    }
}

// MARK: - Table Delegate

extension EpisodeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
