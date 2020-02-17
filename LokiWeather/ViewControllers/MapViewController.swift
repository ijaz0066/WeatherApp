//
//  ViewController.swift
//  LokiWeather
//
//  Created by ijaz ahmad on 2020-02-16.
//  Copyright © 2020 BodiTrak. All rights reserved.
//

import UIKit
import MapKit 

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    private var viewModel: WeatherViewModel!
    
//    fileprivate let locationManager: CLLocationManager = {
//       let manager = CLLocationManager()
//       manager.requestWhenInUseAuthorization()
//       return manager
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mapView.addGestureRecognizer(tapGesture)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "goToWeatherInfo"{
            let vc = segue.destination as! WeatherViewController
            vc.weather = viewModel.weather
            vc.city = viewModel.city
            vc.temprature = viewModel.temprature
            
            //Data has to be a variable name in your RandomViewController
        }
    }
}

extension MapViewController: MKMapViewDelegate {

}
//MARK: -Local Methods
extension MapViewController {
    @objc func handleTap(gestureReconizer: UITapGestureRecognizer) {
        
        let location = gestureReconizer.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate

        if mapView.annotations.count == 1 {
            mapView.removeAnnotation(mapView.annotations.last!)
        }
        mapView.addAnnotation(annotation)
        showActionSheet(coordinate: coordinate)
        
    }
    
    
    func showActionSheet(coordinate: CLLocationCoordinate2D) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Check Weather", style: .default , handler:{ (UIAlertAction)in
            
            let rest = RestApiService(baseUrl: WeatherApiUrl.weather())
            
            self.viewModel = WeatherViewModel(restApiClient: rest, delegate: self)
            self.viewModel.fetchWeatherData(coordinate: coordinate)
            
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Request Error", message: "Request can not be completed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
              }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension  MapViewController: WeatherViewModelDelegate {
    func onFetchCompleted() {
        performSegue(withIdentifier: "goToWeatherInfo", sender: self)
    }
    
    func onFetchFailed(with reason: String) {
        showErrorAlert()
    }
    
    
}

