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
        showLoading(show: true)
        Client.getStudentsLocations { [weak self] (locations, error) in
            if let listController = self?.viewControllers?.last as? ListViewController , listController.isViewLoaded {
                listController.locations = locations
            }
            if let mapController = self?.viewControllers?.first as? MapViewController , mapController.isViewLoaded {
                mapController.locations = locations
            }
            self?.showLoading(show: false)
        }
    }
    
    @IBAction func addLocation(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navController = storyBoard.instantiateViewController(withIdentifier: "NavigationLocation") as? UINavigationController else { return }
        navController.modalPresentationStyle = .fullScreen
        navigationController?.present(navController, animated: true, completion: nil)
    }
    
    @objc private func logout() {
        showLoading(show: true)
        Client.deleteSession { [weak self] (success, error) in
            if error == nil {
                self?.navigationController?.dismiss(animated: true, completion: nil)
            }
            self?.showLoading(show: false)
        }
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
