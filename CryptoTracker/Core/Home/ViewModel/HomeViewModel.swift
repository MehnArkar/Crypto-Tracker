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
    @Published var searchText : String = ""
    
    private var dataService  = CoinDataService()
    private var cancleable = Set<AnyCancellable>()
    
    
    
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
            .combineLatest(dataService.$allCoins)
            .debounce(for:.seconds(0.5) , scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self ] (returnedCoins) in
                self?.allCoins = returnedCoins
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
    
    
}
