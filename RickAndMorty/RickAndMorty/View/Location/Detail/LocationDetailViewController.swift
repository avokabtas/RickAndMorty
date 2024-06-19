//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import UIKit

protocol ILocationDetailUI: AnyObject {
    func update()
}

final class LocationDetailViewController: UIViewController {
    
    private var locationDetailView = LocationDetailView()
    private var presenter: ILocationDetailPresenter
    
    init(presenter: ILocationDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = locationDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoad(ui: self)
        setupTitle()
        setupView()
    }
    
    private func setupTitle() {
        title = presenter.locationName
    }
    
    private func setupView() {
        locationDetailView.tableView.dataSource = self
        locationDetailView.tableView.delegate = self
        locationDetailView.tableView.register(LocationInfoViewCell.self, forCellReuseIdentifier: LocationInfoViewCell.identifier)
        locationDetailView.tableView.register(CharacterViewCell.self, forCellReuseIdentifier: CharacterViewCell.identifier)
        locationDetailView.tableView.register(NoResidentsViewCell.self, forCellReuseIdentifier: NoResidentsViewCell.identifier)
    }
}

// MARK: - UI Update

extension LocationDetailViewController: ILocationDetailUI {
    func update() {
        DispatchQueue.main.async {
            self.locationDetailView.tableView.reloadData()
        }
    }
}

// MARK: - Table Data Source

extension LocationDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter.locationInfo.count
        } else {
            return max(presenter.residentCount, 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return configureLocationInfoCell(at: indexPath, in: tableView)
        } else {
            if presenter.residentCount == 0 {
                return configureNoResidentsCell(in: tableView)
            } else {
                return configureCharacterCell(at: indexPath, in: tableView)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Table.infoSection
        } else {
            return Table.residentsSection
        }
    }
}

// MARK: - Table Delegate

extension LocationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 1 {
            let character = presenter.getResidents(at: indexPath.row)
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

extension LocationDetailViewController {
    private func configureLocationInfoCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationInfoViewCell.identifier, 
                                                       for: indexPath) as? LocationInfoViewCell else {
            return UITableViewCell()
        }
        
        let info = presenter.locationInfo[indexPath.row]
        cell.configure(with: info.title, with: info.value)
        
        return cell
    }
    
    private func configureNoResidentsCell(in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoResidentsViewCell.identifier) as? NoResidentsViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func configureCharacterCell(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.identifier, 
                                                       for: indexPath) as? CharacterViewCell else {
            return UITableViewCell()
        }
        
        let character = presenter.getResidents(at: indexPath.row)
        let info = presenter.getCharacterInfo(for: character)
        cell.configure(with: info.image, name: info.name, status: info.status)
        
        return cell
    }
}
