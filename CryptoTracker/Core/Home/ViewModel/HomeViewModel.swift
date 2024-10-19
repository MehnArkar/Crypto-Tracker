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
    @Published var isLoading : Bool = false
    @Published var sortOption = SortOption.rank
    
    private var coinDataService  = CoinDataService()
    private var cancleable = Set<AnyCancellable>()
    private var portfolioDataService = PortfolioDataService()
    private var marketDataService  = MarketDataService()
    
    enum SortOption{
        case rank, rankRevrsed, holdings, holdingReversed, price, priceReversed
    }
    
    
    
    
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
        
        
        //update all coins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for:.seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterAndSortCoin)
            .sink { [weak self ] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancleable)
        
        //update portfolio coins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinToPortfolioCoin)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else {return}
                self.portfolioCoins = sortPortfolioCoinIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancleable)
        
        // update market data
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(filterGlobalMarketData)
            .sink { [weak  self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancleable)
        
        
        
        
        
        
        
    }
    
    func updatePortfolio(coin : CoinModel, amount : Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoin(text : String, coins : [CoinModel], sortOption : SortOption) -> [CoinModel] {
        var updatedCoins = filterCoins(text: text, coins: coins)
        //sort
        sortCoin(sort: sortOption, coins: &updatedCoins)
        
        return updatedCoins
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
    
    private func sortCoin(sort: SortOption, coins : inout [CoinModel])  {
        switch sort {
        case .rank, .holdings:
            coins.sort(by:{ $0.rank < $1.rank })
            
        case .rankRevrsed, .holdingReversed:
            coins.sort(by: { $0.rank > $1.rank })
            
        case .price:
            coins.sort(by:{ $0.currentPrice > $1.currentPrice })
        
        case .priceReversed:
            coins.sort(by:{ $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinIfNeeded(coins : [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default :
            return coins
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
                let precentageChange  =  ( coin.priceChangePercentage24H ?? 0) / 100
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
