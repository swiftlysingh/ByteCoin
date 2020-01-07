//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,CoinManagerDelegate {
    func didUpdatePrice(price: Double) {
        DispatchQueue.main.async {
            self.currencyLabel.text = self.coinManager.currencyArray[self.rowA!]
            self.value.text = String(format: "%0.1f", price)
        }
    }
    
    

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    var coinManager = CoinManager()
    var rowA :Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  coinManager.currencyArray[row]
    }
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
     }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return coinManager.currencyArray.count;
      }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowA = row
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
      
    

}

