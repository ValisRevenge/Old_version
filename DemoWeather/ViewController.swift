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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let serverUrl = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID={APIKEY}"
    // token - b5ba9264d3ff44e5c0097c7aeda465a7

    var locationManager: CLLocationManager!

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var loadProgressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        request("http://jsonplaceholder.typicode.com/posts", method:.get).validate().responseData {
        //        //request("https://www.youtube.com/watch?v=ymqD89J1ZHg", method:.get).validate().responseJSON {
        //
        //            responce in
        //            switch responce.result {
        //            case .success(let value):
        //                guard let string = String(data: value, encoding: .utf8) else {return}
        //                print("line: ","\(self.i)"," ---\n", string)
        //                break
        //            default:
        //                break
        //            }
        //            self.i += 1
        //        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        request("https://www.universetoday.com/wp-content/uploads/2014/12/201103_VirgoGCM_andreo.jpg").validate().downloadProgress {
            progress in
            self.progressBar.observedProgress = progress
            self.loadProgressLabel.text = progress.localizedDescription ?? "0%"
            }
            .response { responce in
                guard let data = responce.data, let image = UIImage(data:data) else {return}
                self.imageView.image = image
                
                print("success!")
        }
        print("view did load ended")

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
        print(location)
    }


}

