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
    
    private var postCollectionView = PostCollectionView()
    
    private var listener: ListenerRegistration?
    
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.postCollectionView.collectionView.reloadData()
            }
        }
    }
    
    //    @IBAction func createPhoto(_ sender: UIBarButtonItem) {
    //        navigationController?.pushViewController(CreatePostController(), animated: true)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postCollectionView.collectionView.register(PostCell.self, forCellWithReuseIdentifier: "PostCell")
        postCollectionView.collectionView.delegate = self
        postCollectionView.collectionView.dataSource = self
        view = postCollectionView
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}
