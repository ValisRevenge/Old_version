//
//  DataLoader.swift
//  DemoWeather
//
//  Created by Mishko on 4/13/19.
//  Copyright © 2019 322org. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

class DataLoader:NSObject {
    
    let currentWeatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&id=524901&APPID=b5ba9264d3ff44e5c0097c7aeda465a7"
    private let key = "b5ba9264d3ff44e5c0097c7aeda465a7"
    let forecastUrl = "https://api.openweathermap.org/data/2.5/forecast?id=524901&APPID="
    
    class func getCityWeather(city:String)->[String:Any]? {
        var dictionary:[String:Any]?
        request("https://api.openweathermap.org/data/2.5/weather?q=city,uk&id=524901&APPID=b5ba9264d3ff44e5c0097c7aeda465a7", method: .get).validate().responseJSON {
            responce in
            switch responce.result {
            case .success:
                guard let value = responce.result.value as? [String:Any] else {return}
                dictionary = value
                print(value)
                break
            default:
                break
            }
        }
        return dictionary
    }
    
    func getWeatherByCoordinate(coordinate:CLLocation)->[String:Any]? {
        var url:String = currentWeatherUrl.replacingOccurrences(of: "{lat}", with: coordinate.coordinate.latitude.description)
        url = url.replacingOccurrences(of: "{lon}", with: coordinate.coordinate.longitude.description)

        var dictionary:[String:Any] = [:]
        request(url, method: .get).validate().responseJSON {
            responce in
            switch responce.result {
            case .success:
                guard let value = responce.result.value as? [String:Any] else {return}
                dictionary = value
                print(value)
                break
            default:
                break
            }
        }
        return nil
    }
    
}
