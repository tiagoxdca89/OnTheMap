//
//  InformationViewController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var linkTF: UITextField!
    
    let segueIdentifier = "InsertToPost"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onTapDismissKeyboard()
        navigationItem.title = "Add Location"
    }
    
    @IBAction func findLocation(_ sender: UIButton) {
        view.endEditing(true)
        guard isConnectedToInternet() else {
            showAlert(title: "You are not connected to the internet!", message: "")
            return
        }
        if validateFields() {
            self.performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let location = locationTF.text, let link = linkTF.text else {
            return
        }
        guard segue.identifier == segueIdentifier,
            let destination = segue.destination as? AddLocationViewController else { return }
        destination.loc = (location: location, link: link)
    }

    func validateFields() -> Bool {
        guard let location = locationTF.text, !location.isEmpty else {
            showAlert(title: "Invalid Location", message: "Field should not be empty")
            return false
        }
        guard let link = linkTF.text, !link.isEmpty else {
            showAlert(title: "Invalid Link", message: "Field should not be empty")
            return false
        }
        return true
    }
}
