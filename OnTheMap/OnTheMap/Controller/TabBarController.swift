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
    }
    
    @IBAction func refreshData(_ sender: UIBarButtonItem) {
        guard isConnectedToInternet() else {
            showAlert(title: "You are not connected to the internet!", message: "")
            return
        }
        showLoading(show: true)
        Client.getStudentsLocations { [weak self] (locations, error) in
            guard let self = self else { return }
            if locations.count > 0 {
                StudentLocationModel.locations = locations.sorted {
                    $0.updatedAt < $1.updatedAt }
                print("\(locations)")
                if let listController = self.viewControllers?.last as? ListViewController , listController.isViewLoaded {
                    listController.tableView.reloadData()
                }
                if let mapController = self.viewControllers?.first as? MapViewController , mapController.isViewLoaded {
                    mapController.mapView.removeAnnotations(mapController.annotations)
                    mapController.addAnnotationsToMap(locations: locations)
                }
            } else {
                guard let error = error else { return }
                self.showAlert(title: "Something went wrong!", message: error.localizedDescription)
            }
            self.showLoading(show: false)
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
