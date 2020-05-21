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
        mapView.delegate = self
        guard isConnectedToInternet() else {
            showAlert(title: "You are not connected to the internet!", message: "")
            return
        }
        setLocationOnMap()
    }
    
    @IBAction func finishBtn(_ sender: UIButton) {
        sendLocation()
    }
    
    private func sendLocation() {
        showLoading(show: true)
        Client.postStudentLocation(username: "joao.almeida@hotmail.com", password: "135792468txdca") { [weak self] (success, error) in
            if error == nil {
                self?.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                self?.showAlert(title: "Something went wrong", message: error?.localizedDescription ?? "")
            }
            self?.showLoading(show: false)
        }
    }

    private func setLocationOnMap() {
        showLoading(show: true)
        let textLocation = loc?.location ?? ""
        
        self.locationManager.getLocation(forPlaceCalled: textLocation) { [weak self] (location: CLLocation?, error: ErrorType?) in
            guard let location = location else { return }
            if error != nil {
                self?.showAlert(title: "Something went wrong!", message: error?.description ?? "")
            }
            
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
        annotation.title = "\(loc?.location ?? "")"
        self.mapView.addAnnotation(annotation)
    }
}

extension AddLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView?.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
}
