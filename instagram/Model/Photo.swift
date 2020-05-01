//
//  Photo.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation

struct Photo {
    let title: String
    let description: String
      let photoId: String
      let postedDate: Date
      let posterName: String
      let posterId: String
      let imageURL: String
    }

    extension Photo {
      init(_ dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? "no name"
        self.description = dictionary["description"] as? String ?? "no description"
        self.photoId = dictionary["photoId"] as? String ?? "no government id"
        self.postedDate = dictionary["postedDate"] as? Date ?? Date()
        self.posterName = dictionary["posterName"] as? String ?? "no poster name"
        self.posterId = dictionary["posterId"] as? String ?? "no poster id"
        self.imageURL = dictionary["imageURL"] as? String ?? "poop image"
      }
}
