//
//  CharacterImageViewCell.swift
//  RickAndMorty
//
//  Created by Aliia Satbakova  on 14.06.2024.
//

import UIKit

final class CharacterImageViewCell: UITableViewCell {
    
    static let identifier = String(describing: CharacterImageViewCell.self)
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with image: UIImage?) {
        characterImageView.image = image ?? Icon.defaultImage
    }
    
    private func setupView() {
        contentView.addSubview(characterImageView)
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
