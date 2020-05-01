//
//  FeedCellTableViewCell.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    public lazy var postImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.clipsToBounds = true
        imageV.layer.cornerRadius = 10
        imageV.contentMode = .scaleToFill
        imageV.image = UIImage(systemName: "person.fill")
        return imageV
    }()
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(for photo: Photo) {
        titleLabel.text = photo.title
        postImageView.kf.setImage(with: URL(string: photo.imageURL))
    }
    
    private func commonInit() {
        backgroundColor = .systemBackground
        setupImageViewConstraints()
        setupTitleLabelConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postImageView.heightAnchor.constraint(equalToConstant: 100),
            postImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: postImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
}
