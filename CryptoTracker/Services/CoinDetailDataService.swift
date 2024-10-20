//
//  CoinDetailDataService.swift
//  CryptoTracker
//
//  Created by Arkar Min on 10/10/2024.
//

import Foundation
import Combine
import SwiftUI


class CoinDetailDataService {
    @Published var CoinDetails : CoinDetailModel? = nil
    var coinDetailsSubscription : AnyCancellable?
    let coin : CoinModel
    
    init(coin : CoinModel){
        self.coin = coin
        getCoinDetails()
    }
    
    public func getCoinDetails(){
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false&x_cg_demo_api_key=CG-m1dgjZ2xJE4T24QbWT4CY4Cz") else {
            return
        }
        
        coinDetailsSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self , decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails)in
                self?.CoinDetails = returnedCoinDetails
                self?.coinDetailsSubscription?.cancel()
            })
    }

}
