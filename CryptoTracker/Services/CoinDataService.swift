//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by Arkar Min on 22/09/2024.
//

import Foundation
import Combine
import SwiftUI


class CoinDataService {
    @Published var allCoins : [CoinModel]  = []
    var coinSubscription : AnyCancellable?
    
    init(){
        getCoins()
    }
    
    public func getCoins(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&x_cg_demo_api_key=CG-m1dgjZ2xJE4T24QbWT4CY4Cz") else {
            return
        }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self , decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins)in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }

}
