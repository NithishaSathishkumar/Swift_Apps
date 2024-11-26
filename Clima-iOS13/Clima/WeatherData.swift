//
//  WeatherData.swift
//  Clima
//
//  Created by Nithisha Sathishkumar on 6/29/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Decodable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main : Decodable{
    let temp: Double
}

struct Weather : Decodable{
    let main: String
    let description: String
    let id : Int
}

struct Coord : Decodable{
    let lon : Double
    let lat : Double
}
