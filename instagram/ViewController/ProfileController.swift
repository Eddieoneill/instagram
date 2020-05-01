//
//  ProfileController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyboardName: "Login", viewControllerID: "LoginController")
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Error signing out", message: "\(error.localizedDescription)")
            }
        }
    }
}
