//
//  DataBaseService.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
  
  static let photoCollection = "photos"
  
  private let db = Firestore.firestore()
  
    public func createItem(photoTitle: String, photoDescription: String, posterName: String, completion: @escaping (Result<String, Error>) -> ()) {
    guard let user = Auth.auth().currentUser else { return }
    
    let documentRef = db.collection(DatabaseService.photoCollection).document()
    db.collection(DatabaseService.photoCollection).document(documentRef.documentID).setData(["title":photoTitle,"description": photoDescription, "photoId":documentRef.documentID, "postedDate": Timestamp(date: Date()), "posterName": posterName,"posterId": user.uid]) { (error) in
      if let error = error {
        completion(.failure(error))
      } else {
        completion(.success(documentRef.documentID))
      }
    }
  }
  
}
