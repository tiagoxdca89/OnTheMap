//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 16/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func performLogin(_ sender: Any) {
        guard isConnectedToInternet() else {
            showAlert(title: "You are not connected to the internet!", message: "")
            return
        }
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        guard !email.isEmpty else {
            showAlert(title: "Invalid!", message: "UserName should not be empty.")
            return
        }
        guard !password.isEmpty else {
            showAlert(title: "Invalid!", message: "Password should not be empty.")
            return
        }
        
        showLoading(show: true)
        Client.login(username: email, password: password) { [weak self] (success, error) in
            if error == nil {
                self?.showTabBar()
                self?.cleanFields()
            } else {
                guard let error = error else { return }
                self?.showAlert(title: "Someting went wrong", message: "\(String(describing: error.localizedDescription))")
            }
            self?.showLoading(show: false)
        }
    }
    
    @IBAction func performSignUp(_ sender: Any) {
        guard let url = URL(string: "https://auth.udacity.com/sign-up") else {
            showAlert(title: "Could not open Safari.", message: "This link is not valid.")
            return
        }
        UIApplication.shared.open(url)
    }
    
    private func cleanFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
    }

    private func showTabBar() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyBoard.instantiateViewController(withIdentifier: "NavigationController") as? NavigationViewController else { return }
        navigationController.navigationItem.title = "On The Map"
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        present(navigationController, animated: true, completion: nil)
    }
}
