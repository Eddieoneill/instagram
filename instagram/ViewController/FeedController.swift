//
//  FeedController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FeedController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var listener: ListenerRegistration?
    
    private var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        listener = Firestore.firestore().collection(DatabaseService.photoCollection).addSnapshotListener({ [weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Try again later", message: "\(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let photos = snapshot.documents.map { Photo($0.data()) }
                self?.photos = photos
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }
}

extension FeedController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else {
            fatalError("could not downcast to FeedViewCell")
        }
        let photo = photos[indexPath.row]
        cell.configureCell(for: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = photos[indexPath.row]
        let vc = DetailController(photo: selected)
        present(vc, animated: true)
    }
}


