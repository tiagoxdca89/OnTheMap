//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 16/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

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
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyBoard.instantiateViewController(withIdentifier: "NavigationController") as? NavigationViewController else { return }
        navigationController.navigationItem.title = "On The Map"
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .flipHorizontal
        present(navigationController, animated: true, completion: nil)
    }
    
    
    @IBAction func performSignUp(_ sender: Any) {
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
