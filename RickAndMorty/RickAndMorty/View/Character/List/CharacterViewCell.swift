//
//  CharacterViewCell.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 12.06.2024.
//

import UIKit

final class CharacterViewCell: UITableViewCell {
    
    static let identifier = String(describing: CharacterViewCell.self)
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.cellMainText
        label.numberOfLines = Font.noLimit
        label.textAlignment = .left
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.cellBodyText
        label.textColor = Color.descriptionLabel
        label.textAlignment = .left
        return label
    }()
    
    private let statusIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.widthAnchor.constraint(equalToConstant: 8).isActive = true
        view.heightAnchor.constraint(equalToConstant: 8).isActive = true
        return view
    }()
    
    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
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
    
    func configure(with image: UIImage?, name: String, status: String) {
        characterImageView.image = image
        nameLabel.text = name
        statusLabel.text = status
        statusIndicator.backgroundColor = statusColor(for: status)
    }
    
    private func setupView() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(mainStackView)
        
        statusStackView.addArrangedSubview(statusIndicator)
        statusStackView.addArrangedSubview(statusLabel)
        
        mainStackView.addArrangedSubview(nameLabel)
        mainStackView.addArrangedSubview(statusStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            characterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func statusColor(for status: String) -> UIColor {
        switch status {
        case "Alive": return Color.aliveStatus
        case "Dead": return Color.deadStatus
        case "unknown": return Color.unknownStatus
        default: return .gray
        }
    }
}
