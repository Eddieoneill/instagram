//
//  LoginController.swift
//  instagram
//
//  Created by Edward O'Neill on 4/30/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class LoginController: UIViewController {
    
    @IBOutlet weak var loginTypeLabel: UILabel!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var accountState: AccountState = .existingUser
    private var authSession = AuthenticationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearLabel()
    }
    
    @IBAction func signinButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Invalid information", message: "Please double check your email and password")
            return
        }
        SignIn(email: email, password: password)
    }
    
    @IBAction func typeChangeButtonPressed(_ sender: UIButton) {
        accountState = accountState == .newUser ? .existingUser : .newUser
        if accountState == .existingUser {
            signinButton.setTitle("Sign in", for: .normal)
            loginTypeLabel.text = "If you don't have an account press:"
            sender.setTitle("Sign Up", for: .normal)
            
        } else {
            signinButton.setTitle("Sign Up", for: .normal)
            loginTypeLabel.text = "If you have an account:"
            sender.setTitle("Login", for: .normal)
        }
    }
    
    private func clearLabel() {
        errorLabel?.text = ""
    }
    
    private func SignIn(email: String, password: String) {
        if accountState == .existingUser {
            authSession.signExistingUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorLabel.text = "\(error.localizedDescription)"
                        self?.errorLabel.textColor = .systemRed
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.mainView()
                    }
                }
            }
        } else {
            authSession.createNewUser(email: email, password: password) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorLabel.text = "\(error.localizedDescription)"
                        self?.errorLabel.textColor = .systemRed
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.mainView()
                    }
                }
            }
        }
    }
    
    private func mainView() {
        UIViewController.showViewController(storyboardName: "Main", viewControllerID: "MainTabBarController")
    }
    
}

extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
