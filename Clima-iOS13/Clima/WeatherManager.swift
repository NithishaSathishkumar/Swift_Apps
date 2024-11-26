//
//  WeatherManager.swift
//  Clima
//
//  Created by Nithisha Sathishkumar on 6/29/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather : WeatherModel)
    func didFailWithError(_ error: Error)
    
}

struct WeatherManager{
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=8e5a37f532e4f20b73184c2d870f34cb&units=imperial"
    
    var delegate : WeatherManagerDelegate?
        
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat\(latitude)&lon\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String){
        //Create a URL
        if let url = URL(string: urlString){
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Gives the session task
            //select blue and click enter convert into closure
            let task = session.dataTask(with: url) {(data, respone, error) in
                if(error != nil){
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data{
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString)
                    if let weather = parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                }
            }
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try  decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temp: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
    //let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
    
    //    func handle(data: Data?, response: URLResponse?, error: Error?){
    //        if(error != nil){
    //            print(error!)
    //            return
    //        }
    //
    //        if let safeData = data{
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString)
    //        }
}

