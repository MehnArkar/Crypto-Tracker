//
//  CoinDetailModel.swift
//  CryptoTracker
//
//  Created by Arkar Min on 10/10/2024.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketDataModel = try? JSONDecoder().decode(MarketDataModel.self, from: jsonData)

import Foundation

struct CoinDetailModel : Codable{
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case description, links
    }
    
    
}


struct Description : Codable{
    let en: String?
}

struct Links : Codable{
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}
