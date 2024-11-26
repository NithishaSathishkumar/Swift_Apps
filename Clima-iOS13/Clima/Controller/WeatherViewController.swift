//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    //SF'Symbol
    //Image: pdf resizing-select,scales-single,appearance-all3
    
    @IBAction func currentLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    
    //Main
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weatherManager.delegate = self
        searchBar.delegate = self
        
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
    @IBAction func search(_ sender: UIButton) {
        searchBar.endEditing(true) //move the keyboard away
        print(searchBar.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //search in keyboard
        searchBar.endEditing(true) //move the keyboard away
        print(searchBar.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { //clear the search bar after search and show the result
        if let city = searchBar.text{
            weatherManager.fetchWeather(cityName: city)
        }
        //Use searchBar.text to get the weather for that city
        searchBar.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool { // when should the keyboard vanish
        if(textField.text != ""){
            return true
        }else{
            textField.placeholder = "Enter A City Name"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let last = location.coordinate.latitude
            let long = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: last, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
