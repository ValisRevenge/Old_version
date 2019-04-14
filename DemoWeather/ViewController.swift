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
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var weatherPictureBox: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    var locationManager: CLLocationManager!
    
    var loader:DataLoader = DataLoader()
    
    var weatherDictionary:[String:Any]? {
        didSet {
            readData(dictionary: weatherDictionary)
        }
    }
    var forecastDictionary:[String:Any]?
    
    var location:CLLocation? {
        didSet {
            if let point = location {
                loader.getWeatherByCoordinate(coordinate: point, completed: downloadWeather)
                loader.getForecastByCity(coordinate: point, completed: downloadForecast)
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
    
    @objc func downloadWeather(dictionary:[String:Any]) {
        weatherDictionary = dictionary
    }
    
    @objc func downloadForecast(dictionary:[String:Any]) {
        forecastDictionary = dictionary
    }
    
    func readData(dictionary:[String:Any]?) {
        guard let info = dictionary else {return}
        if let weather = info["weather"] as? [[String:Any]] {
            let imageType = weather[0]["main"] as! String
            switch imageType {
            case "Clear":
                weatherPictureBox.image = #imageLiteral(resourceName: "bright_sunny")
                break
            case "Snow":
                weatherPictureBox.image = #imageLiteral(resourceName: "snow")
                break
            case "Clouds":
                weatherPictureBox.image = #imageLiteral(resourceName: "cloudy")
            default:
                weatherPictureBox.image = #imageLiteral(resourceName: "rain")
                break
            }
            
        }
        if let weather = info["main"] as? [String:Any] {
            temperatureLabel.text = weather["temp"] as? String ?? "0'C"
            pressureLabel.text = "pressure: " + (weather["pressure"] as? String ?? "???")
            humidityLabel.text = "humidity: " + (weather["humidity"] as? String ?? "???")
            windLabel.text = "wind:" +  (weather["wind"] as? String ?? "???")
        }
        if let sysInfo = info["sys"] as? [String:Any] {
            cityLabel.text = sysInfo["name"] as? String ?? "???"
        }
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
        self.location = manager.location
        //print(location)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forecastSegue" {
            let dc = segue.destination as! UINavigationController
            let vc = dc.topViewController! as! WeekWeatherViewController
            vc.forecastDictionary = forecastDictionary
        }
    }

}

