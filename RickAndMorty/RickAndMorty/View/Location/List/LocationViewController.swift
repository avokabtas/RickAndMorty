//
//  LocationViewController.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 09.06.2024.
//

import UIKit

protocol ILocationUI: AnyObject {
    func update()
}

final class LocationViewController: UIViewController {
    
    var presenter: ILocationPresenter
    private var locationView = LocationView()
    private let searchController = UISearchController()
    
    init(presenter: ILocationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = locationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupSearch()
        setupView()
        locationView.startIndicator()
        presenter.loadLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = locationView.tableView.indexPathForSelectedRow {
            locationView.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func setupNavBar() {
        title = TextData.locationTitleVC.rawValue
        navigationItem.searchController = searchController
    }
    
    private func setupView() {
        locationView.tableView.delegate = self
        locationView.tableView.dataSource = self
        locationView.tableView.register(LocationViewCell.self, forCellReuseIdentifier: LocationViewCell.identifier)
    }
}

// MARK: - UI Update

extension LocationViewController: ILocationUI {
    func update() {
        DispatchQueue.main.async {
            self.locationView.stopIndicator()
            self.locationView.tableView.reloadData()
        }
    }
}

// MARK: - Table Delegate

extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //
    }
}

// MARK: - Table Data Source

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationViewCell.identifier, for: indexPath) as? LocationViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        
        let location = presenter.locations[indexPath.row]
        cell.configure(with: location.name)
        
        return cell
    }
}

// MARK: - Search Delegate

extension LocationViewController: UISearchBarDelegate {
    private func setupSearch() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search the Location"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            presenter.fetchLocationsFromDB()
        } else {
            presenter.searchLocations(with: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.fetchLocationsFromDB()
    }
}
