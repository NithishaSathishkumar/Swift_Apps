//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets for UI elements
    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    // Reference to the CoinManager struct
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source and delegate for the picker view
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        // Set the delegate for the CoinManager
        coinManager.delegate = self
        
    }
}

//MARK: - UIPickerView DataSource & Delegate

// Extension to conform to UIPickerViewDataSource and UIPickerViewDelegate protocols
extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate{
    
    // Specify the number of components in the picker view (1 component)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    // Specify the number of rows in the picker view using the currency array
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
        
    // Set the title for each row in the picker view to the corresponding currency
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // Handle the event when a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let selectedCurrency = coinManager.currencyArray[row]
        
        // Get the coin price for the selected currency
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManagerDelegate

// Extension to conform to the CoinManagerDelegate protoco
extension ViewController : CoinManagerDelegate{
    
    // Handle the updated price and update the UI
    func didUpdatePrice(price : String, currency: String){
        DispatchQueue.main.async{
            self.currencyLabel.text = currency
            self.bitcoinLabel.text = price
        }
    }
        
    // Handle errors
    func didFailWithError(error : Error){
        print(error)
    }
}
    


