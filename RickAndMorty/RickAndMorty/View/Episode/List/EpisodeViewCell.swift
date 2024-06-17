//
//  EpisodeViewCell.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 13.06.2024.
//

import UIKit

final class EpisodeViewCell: UITableViewCell {
    
    static let identifier = String(describing: EpisodeViewCell.self)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.cellMainText
        label.numberOfLines = Font.noLimit
        label.textAlignment = .left
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.cellBodyText
        label.textAlignment = .left
        label.textColor = Color.secondaryText
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with name: String, episode: String) {
        nameLabel.text = name
        episodeLabel.text = episode
    }
    
    private func setupView() {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(episodeLabel)
        contentView.addSubview(stackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
