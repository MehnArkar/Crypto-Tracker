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
    private var portfolioDataService = PortfolioDataService()
    
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
        
        //update portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinToPortfolioCoin)
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancleable)
        
        // update market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(filterGlobalMarketData)
            .sink { [weak  self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancleable)
        
        
        
        
        
        
        
    }
    
    func updatePortfolio(coin : CoinModel, amount : Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapAllCoinToPortfolioCoin(allCoins : [CoinModel], portfolioEntities : [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else { return nil }
            return coin.updateCoinModel(amount: entity.amount)
        }
    }
    
    private func filterGlobalMarketData( marketData: MarketDataModel?, portfolioCoins : [CoinModel] ) -> [StatisticModel] {
        var stats : [StatisticModel] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Domainance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map ({  $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map { (coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let precentageChange  =  coin.priceChangePercentage24H / 100
                let previousValue = currentValue / (1 + precentageChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let protfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            protfolio
        ])
        
        return stats

    }
    
    
    
    
}
