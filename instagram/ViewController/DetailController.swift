//
//  DetailController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    private let detailView = DetailView()
    
    private var photo: Photo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.titleLabel.text = photo.title
        detailView.descriptionLabel.text = "Date Posted: \(photo.postedDate) by \(photo.posterName) \n \(photo.description)"
        detailView.photoImageView.kf.setImage(with: URL(string: photo.imageURL))
        view = detailView
    }
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
