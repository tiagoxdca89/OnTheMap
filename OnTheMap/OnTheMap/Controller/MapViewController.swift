//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 16/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var annotations = [MKPointAnnotation]()
    var locations: [StudentLocation] = [] {
        didSet {
            mapView.removeAnnotations(annotations)
            addAnnotationsToMap(locations: locations)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupViews()
        Client.getStudentsLocations { [weak self] (locations, error) in
            if locations.count > 0 {
               self?.locations = locations
            } else {
                guard let error = error else { return }
                self?.showAlert(title: "Something went wrong!", message: error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        navigationItem.title = "On The Map"
    }
}

extension MapViewController: MKMapViewDelegate {
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            guard let toOpen = view.annotation?.subtitle, toOpen != nil else {
                print("Something went wrong")
                return
            }
            guard let url = URL(string: toOpen ?? "") else {
                print("url not valid")
                return
            }
            app.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func addAnnotationsToMap(locations: [StudentLocation]) {
        for location in locations {
            
            let lat = CLLocationDegrees(location.latitude)
            let long = CLLocationDegrees(location.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName
            let last = location.lastName
            let mediaURL = location.mediaURL
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            annotations.append(annotation)
        }
        self.mapView.addAnnotations(annotations)
    }
}
