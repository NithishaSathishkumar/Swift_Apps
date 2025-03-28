//
//  DataManager.swift
//  ByteCoin
//
//  Created by Nithisha Sathishkumar on 7/17/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

// Struct to decode the JSON response from CoinAPI
struct DataManager : Codable{
    
    // Property to store the exchange rate
    let rate : Double
}
