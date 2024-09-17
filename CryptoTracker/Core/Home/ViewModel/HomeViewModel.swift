//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Arkar Min on 20/09/2024.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    
    private var dataService  = CoinDataService()
    private var cancleable = Set<AnyCancellable>()
    
    
    
    init(){
        addSubscriber()
    }
    
    
    func addSubscriber(){
        dataService.$allCoins
            .sink{ [weak self](returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancleable)
    }
    
    
}
