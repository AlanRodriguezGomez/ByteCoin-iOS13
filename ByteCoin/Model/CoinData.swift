//
//  CoinData.swift
//  ByteCoin
//
//  Created by Alan Josue Rodriguez Gomez on 07/04/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation


struct CoinData: Decodable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
