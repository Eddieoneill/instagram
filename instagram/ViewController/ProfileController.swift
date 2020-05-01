//
//  ProfileController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit
import FirebaseAuth
import Kingfisher

class ProfileController: UIViewController {
    
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    private let storageService = StorageService()
    
    private var selected: UIImage? {
        didSet {
            profileImageButton.setImage(selected, for: .normal)
        }
    }
    
    private lazy var imagePickerController: UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.delegate = self
        return ip
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    @IBAction func updateProfileButtonPressed(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else {
                   return
               }
        guard let displayName = userNameTextField.text,
                   !displayName.isEmpty, let selectedImage = selected else {
                       print("missing fields")
                       return
               }
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: profileImageButton.bounds)
               
               storageService.uploadPhoto(userID: user.uid, image: resizedImage) { [weak self] (result) in
                   DispatchQueue.main.async {
                       switch result {
                       case .failure(let error):
                           self?.showAlert(title: "error uploading photo", message: "\(error.localizedDescription)")
                       case .success(let url):
                           let request = Auth.auth().currentUser?.createProfileChangeRequest()
                           request?.displayName = displayName
                           request?.photoURL = url
                           request?.commitChanges(completion: { [unowned self] (error) in
                               if let error = error {
                                   self?.showAlert(title: "Profile Update", message: "Error changing profile: \(error.localizedDescription).")
                               } else {
                                   self?.showAlert(title: "Profile Update", message: "Profile successfully updated.")
                               }
                           })
                       }
                   }
               }
    }
    @IBAction func profileImageButtonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Choose Photo Option", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { alertAction in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { alertAction in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
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
    
    private func updateUI() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        emailLabel.text = user.email
        userNameTextField.text = user.displayName
        profileImageButton.kf.setImage(with: user.photoURL, for: .normal)
    }
}

extension ProfileController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        selected = image
        dismiss(animated: true)
    }
}
