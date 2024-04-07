//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateData(_ coinManager: CoinManager, coin: CoinData)
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5C48677D-9AC0-47C4-9D33-0BEF01D3B6A1"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        let url = baseURL + "/\(currency)"
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(parseJSON(safeData))
                    if let coin = self.parseJSON(safeData) {
                        self.delegate?.didUpdateData(self, coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return decodedData
        } catch {
            delegate?.didFailWithError(error: error)
            return  nil
        }
        
    }
}
