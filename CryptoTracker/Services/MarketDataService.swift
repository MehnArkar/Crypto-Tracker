//
//  MarketDataService.swift
//  CryptoTracker
//
//  Created by Arkar Min on 26/09/2024.
//

import Foundation
import Combine
import SwiftUI


class MarketDataService {
    @Published var marketData : MarketDataModel? = nil
    var marketDataSubscription : AnyCancellable?
    
    init(){
        getMarketData()
    }
    
    public func getMarketData(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global?x_cg_demo_api_key=CG-m1dgjZ2xJE4T24QbWT4CY4Cz") else {
            return
        }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self , decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedMarketData)in
                self?.marketData = returnedMarketData.data
                self?.marketDataSubscription?.cancel()
            })
    }

}


