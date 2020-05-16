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
    @IBOutlet weak var signUpLabel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboard()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func performLogin(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        guard !email.isEmpty && !password.isEmpty else { return }
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController else { return }
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .flipHorizontal
        present(tabBarController, animated: true, completion: nil)
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

extension LoginViewController {
    private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}
