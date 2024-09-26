//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Arkar Min on 20/09/2024.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var statistics : [StatisticModel] = []
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    
    private var coinDataService  = CoinDataService()
    private var cancleable = Set<AnyCancellable>()
    
    private var marketDataService  = MarketDataService()
    
    
    
    init(){
        addSubscriber()
    }
    
    
    func addSubscriber(){
        
        //get coin from api
//        dataService.$allCoins
//            .sink{ [weak self](returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancleable)
        
        
        //get coin form api and filter by search text
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for:.seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self ] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancleable)
        
        marketDataService.$marketData
            .map(filterGlobalMarketData)
            .sink { [weak  self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancleable)
        
    }
    
    private func filterCoins(text : String, coins : [CoinModel]) -> [CoinModel] {
        if(text.isEmpty) { return coins }
        
        let lowerCaseText = text.lowercased()
        
        return coins.filter { (coin) -> Bool in
           return coin.name.lowercased().contains(lowerCaseText) ||
            coin.symbol.lowercased().contains(lowerCaseText) ||
            coin.id.lowercased().contains(lowerCaseText)
        }
    }
    
    private func filterGlobalMarketData( marketData: MarketDataModel? ) -> [StatisticModel] {
        var stats : [StatisticModel] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Domainance", value: data.btcDominance)
        let protfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0.0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            protfolio
        ])
        
        return stats

    }
    
    
    
    
}
