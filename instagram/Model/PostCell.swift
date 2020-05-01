//
//  PostCell.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    public lazy var photoImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemName: "person")
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.black.cgColor
        return image
    }()
    
    override init(frame:CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        photoConstraints()
    }
    
    private func photoConstraints() {
        addSubview(photoImage)
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            photoImage.topAnchor.constraint(equalTo: topAnchor),
//            photoImage.leadingAnchor.constraint(equalTo: trailingAnchor),
//            photoImage.trailingAnchor.constraint(equalTo: leadingAnchor),
//            photoImage.bottomAnchor.constraint(equalTo: bottomAnchor)
            photoImage.heightAnchor.constraint(equalToConstant: 200),
            photoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    public func configureCell(_ photo: Photo) {
        photoImage.kf.setImage(with: URL(string: photo.imageURL))
    }
}
