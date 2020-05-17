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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onTapDismissKeyboard()
        navigationItem.title = "Add Location"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func findLocation(_ sender: UIButton) {
        view.endEditing(true)
        self.performSegue(withIdentifier: "InsertToPost", sender: nil)
        
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "InsertToPost", let destination = segue.destination as? AddLocationViewController else { return }
    }

}
