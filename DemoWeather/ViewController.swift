//
//  ViewController.swift
//  DemoWeather
//
//  Created by Mishko on 4/12/19.
//  Copyright © 2019 322org. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

//current weather  "https://api.openweathermap.org/data/2.5/weather?id=524901&APPID=b5ba9264d3ff44e5c0097c7aeda465a7"
//current weather  "https://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=b5ba9264d3ff44e5c0097c7aeda465a7"

//
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherPictureBox: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    var loader:DataLoader = DataLoader()
    
    var location:CLLocation? {
        didSet {
            if let point = location {
                loader.getWeatherByCoordinate(coordinate: point)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate else {return}
        loader.getWeatherByCoordinate(coordinate: manager.location!)
        //print(location)
    }


}

