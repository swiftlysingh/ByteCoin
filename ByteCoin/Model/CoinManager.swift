//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price : Double)
}

struct CoinManager {
  
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
    func  getCoinPrice(for currency : String)  {
        let url = "\(baseURL)\(currency)"
       performRequest(with: url)
    }

   func performRequest(with urlString : String)  {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){
                (data,response,error) in
                if error != nil {
                    
                 return
                }
                if let safeData = data{
                    if let price : Double = self.parseJSON(data: safeData){
                        self.delegate?.didUpdatePrice(price: price)
                    }
                }
            }
            task.resume()
        }
    }
    
  func parseJSON(data : Data) -> Double{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
           return decodedData.last
            
        } catch{
            return 0.0
        }
    }
}
