//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 12.06.2024.
//

import UIKit

final class CharacterView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let indicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    let statusSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["All", "Alive", "Dead", "Unknown"])
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.selectedSegmentIndex = 0
        return segmentControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupSegmentControl()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        //backgroundColor = UIColor(named: "backgroundColor")
        addSubview(tableView)
        addSubview(indicatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupSegmentControl() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
        headerView.addSubview(statusSegmentControl)
        
        NSLayoutConstraint.activate([
            statusSegmentControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            statusSegmentControl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            statusSegmentControl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            statusSegmentControl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
        ])
        
        tableView.tableHeaderView = headerView
    }
    
    func startIndicator() {
        tableView.isHidden = true
        indicatorView.startAnimating()
    }
    
    func stopIndicator() {
        tableView.isHidden = false
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
    }
}
