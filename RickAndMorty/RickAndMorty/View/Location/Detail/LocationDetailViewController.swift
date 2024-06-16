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
        // Настройка для поддержки динамической высоты ячеек
        locationDetailView.tableView.rowHeight = UITableView.automaticDimension
        locationDetailView.tableView.dataSource = self
        locationDetailView.tableView.delegate = self
        locationDetailView.tableView.register(LocationInfoViewCell.self,
                                               forCellReuseIdentifier: LocationInfoViewCell.identifier)
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.locationInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationInfoViewCell.identifier,
                                                       for: indexPath) as? LocationInfoViewCell else {
            return UITableViewCell()
        }
        let info = presenter.locationInfo[indexPath.row]
        cell.configure(with: info.title, with: info.value)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Table.infoSection
    }
}

// MARK: - Table Delegate

extension LocationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
