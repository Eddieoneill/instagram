//
//  StorageService.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    private let storageRef = Storage.storage().reference()
    
    public func uploadPhoto(userID: String? = nil, photoId: String? = nil, image: UIImage, completion: @escaping (Result<URL,Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        var photoReference: StorageReference!
        if let userId = userID {
            photoReference = storageRef.child("UserProfilePhotos/\(userId).jpg")
        } else if let photoId = photoId {
            photoReference = storageRef.child("UserPhotos/\(photoId).jpg")
        }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let _ = photoReference.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            } else if let _ = metadata {
                photoReference.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
    }
    
}

