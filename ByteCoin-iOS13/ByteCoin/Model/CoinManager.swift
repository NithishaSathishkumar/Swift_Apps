//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

// URL to fetch the exchange rate of BTC to USD using CoinAPI
// Example: https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=87A2BCE5-65F7-482B-A4C8-53BB830EF395

// Protocol to define delegate methods for updating price and handling errors
protocol CoinManagerDelegate {
    func didUpdatePrice(price : String, currency: String)
    func didFailWithError(error : Error)
}

// Struct to manage coin-related functionalities
struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC" // Base URL for CoinAPI
    let apiKey = "87A2BCE5-65F7-482B-A4C8-53BB830EF395" // API key for authentication
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"] // List of supported currencies
    
    var delegate: CoinManagerDelegate? // Delegate to handle callbacks
    
    // Method to fetch coin price for a specific currency
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)" // Construct the URL string
        
            if let url = URL(string: urlString) { // Convert the string to a URL
                let session = URLSession(configuration: .default) // Create a URLSession
                
                // Create a data task to fetch data from the URL
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil { // Handle errors
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                       
                    if let safeData = data { // If data is received
                        if let bitcoinPrice = self.parseJSON(safeData) { // Parse the JSON data
                               
                            // Format the price to 2 decimal places
                            let priceString = String(format: "%.2f", bitcoinPrice)
                               
                            // Call the delegate method to update the price
                            self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                        }
                    }
                }
                // Start the data task
                task.resume()
            }
    }
    
    // Method to parse JSON data
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder() // Create a JSONDecoder
        do{
            let decodedData = try decoder.decode(DataManager.self, from: data) // Decode the data into a DataManager object
            let lastPrice = decodedData.rate // Extract the rate from the decoded data
            return lastPrice // Return the rate
        }catch{
            self.delegate?.didFailWithError(error: error) // Handle decoding errors
            return nil
        }
    }
}
