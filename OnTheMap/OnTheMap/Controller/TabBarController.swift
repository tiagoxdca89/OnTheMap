//
//  TabBarController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "On the Map"
        setupLeftBarButtonItem()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        print("Tap on refresh")
    }
    
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navController = storyBoard.instantiateViewController(withIdentifier: "NavigationLocation") as? UINavigationController else { return }
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @objc private func logout() {
        print("Click on Logout button")
    }
    

}

extension TabBarController {
    
    private func setupLeftBarButtonItem() {
        let logoutBtn = UIButton(type: .system)
        logoutBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        logoutBtn.addTarget(self, action: #selector(logout), for:    .touchUpInside)
        logoutBtn.setTitle("LOGOUT", for: .normal)
        let menuBarButtonItem = UIBarButtonItem(customView: logoutBtn)

        navigationItem.leftBarButtonItems = [menuBarButtonItem]
    }
}
