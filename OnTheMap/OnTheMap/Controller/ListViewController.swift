//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 16/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchStudentsInformation()
    }
    
    private func fetchStudentsInformation() {
        guard isConnectedToInternet() else {
            showAlert(title: "You are not connected to the internet!", message: "")
            return
        }
        showLoading(show: true)
        Client.getStudentsLocations { [weak self] (locations, error) in
            let sortedLocations = locations.sorted {
                $0.updatedAt < $1.updatedAt
            }
            StudentLocationModel.locations = sortedLocations
            self?.tableView.reloadData()
            self?.showLoading(show: false)
        }
    }
    
    private func setupViews() {
        navigationItem.title = "ListView"
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        let location = StudentLocationModel.locations[indexPath.row]
        cell.setup(location: location)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentLocationModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let location = StudentLocationModel.locations[indexPath.row]
        guard let url = URL(string: location.mediaURL), location.mediaURL.isValidURLString() else {
            showAlert(title: "Could not open Safari.", message: "This link is not valid.")
            return
        }
        UIApplication.shared.open(url)
    }
}
