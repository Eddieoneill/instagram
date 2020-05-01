//
//  PostController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class PostController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var listener: ListenerRegistration?
    
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
//    @IBAction func createPhoto(_ sender: UIBarButtonItem) {
//        navigationController?.pushViewController(CreatePostController(), animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listener = Firestore.firestore().collection(DatabaseService.photoCollection).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Try again later", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let allPhoto = snapshot.documents.map { Photo($0.data()) }
                self?.photos = allPhoto.filter { $0.posterId == Auth.auth().currentUser?.uid}
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }
    
}

extension PostController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCell else {
      fatalError("could not downcaset to PhotoCollectionViewCell")
    }
    let photo = photos[indexPath.row]
    cell.configureCell(photo)
    return cell
  }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = photos[indexPath.row]
        let vc = DetailController(photo: selected)
        present(vc, animated: true, completion: nil)
    }
}
