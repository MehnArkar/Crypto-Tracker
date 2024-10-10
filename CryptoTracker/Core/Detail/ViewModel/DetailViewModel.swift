//
//  DetailViewModel.swift
//  CryptoTracker
//
//  Created by Arkar Min on 10/10/2024.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject {
    
    private let coinDetailDataService : CoinDetailDataService
    private var cancable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$CoinDetails
            .sink {(returnedCoinDetails) in
                print("Received coin details")
                print(returnedCoinDetails)}
            .store(in: &cancable)
    }
    
}
