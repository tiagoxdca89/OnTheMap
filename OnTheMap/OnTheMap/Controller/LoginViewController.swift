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
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func performLogin(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        guard !email.isEmpty && !password.isEmpty else { return }
        
        showLoading(show: true)
        Client.login(username: email, password: password) { [weak self] (success, error) in
            if error == nil {
                self?.showTabBar()
            } else {
                self?.showAlert()
            }
            self?.showLoading(show: false)
        }
    }
    
    
    @IBAction func performSignUp(_ sender: Any) {
        guard let url = URL(string: "https://auth.udacity.com/sign-up") else {
            showAlert()
            return
        }
        UIApplication.shared.open(url)
    }

    private func showTabBar() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyBoard.instantiateViewController(withIdentifier: "NavigationController") as? NavigationViewController else { return }
        navigationController.navigationItem.title = "On The Map"
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        present(navigationController, animated: true, completion: nil)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Something went wrong", message: "Please try again...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
