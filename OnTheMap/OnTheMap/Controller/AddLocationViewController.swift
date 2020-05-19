//
//  AddLocationViewController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import MapKit

typealias SearchLocation = (location: String, link: String)

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var loc: SearchLocation?
    
    lazy var locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
    }
    
    @IBAction func finishBtn(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    private func setLocation() {
        showLoading(show: true)
        let textLocation = "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France"
        
        self.locationManager.getLocation(forPlaceCalled: textLocation) { [weak self] (location: CLLocation?, error: ErrorType?) in
            guard let location = location else { return }
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self?.mapView.setRegion(region, animated: true)
            self?.addAnotation(coordinate: location.coordinate)
            self?.showLoading(show: false)
        }
    }
    
    private func addAnotation(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "\(loc?.link ?? "Something went wrong!")"
        self.mapView.addAnnotation(annotation)
    }
}
