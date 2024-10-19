//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Arkar Min on 10/10/2024.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    @Published var overviewStatistics : [StatisticModel] = []
    @Published var additionalStatistics : [StatisticModel] = []
    @Published var coin : CoinModel
    @Published var coinDescription : String?
    @Published var websiteURL : String?
    @Published var redditURL : String?
    private let coinDetailDataService : CoinDetailDataService
    private var cancable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$CoinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink {[weak self] (returnedArrays) in
                
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancable)
        
        coinDetailDataService.$CoinDetails
            .sink {[weak self] returnedCoinDetail in
                self?.coinDescription = returnedCoinDetail?.readableDescription
                self?.websiteURL = returnedCoinDetail?.links?.homepage?.first
                self?.redditURL = returnedCoinDetail?.links?.subredditURL
            }
            .store(in: &cancable)
    }
    
    private func mapDataToStatistics(coinDetailModel : CoinDetailModel?, coinModel: CoinModel) -> (overview : [StatisticModel] , additional : [StatisticModel]){
        
        let overviewArray : [StatisticModel] = createOverviewArray(coinModel: coinModel)
        let additionalArray : [StatisticModel] = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        
        return (overviewArray, additionalArray)
    }
    
    private func createOverviewArray (coinModel : CoinModel) -> [StatisticModel]{
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercenChange = coinModel.priceChangePercentage24H
        let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: pricePercenChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketPercentCapChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketPercentCapChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func createAdditionalArray (coinModel : CoinModel , coinDetailModel : CoinDetailModel?) -> [StatisticModel]{
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatisticModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatisticModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
       return [
            highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingStat
        ]
    }
}
