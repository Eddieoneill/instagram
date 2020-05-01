//
//  DetailController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var photo: Photo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = photo.title
        descriptionLabel.text = "Date Posted: \(photo.postedDate) by \(photo.posterName) \n \(photo.description)"
        imageView.kf.setImage(with: URL(string: photo.imageURL))
    }
    
    init(photo: Photo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
