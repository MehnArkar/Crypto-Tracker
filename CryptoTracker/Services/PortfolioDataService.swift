//
//  PortfolioDataService.swift
//  CryptoTracker
//
//  Created by Arkar Min on 04/10/2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    private let container : NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities : [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { des, error in
            if let error = error {
                print("Error in loading persistent store: \(error)")
            }
            self.getPortfolio()
        }
        
    }
    // MARK: PUBLIC
    
    func updatePortfolio (coin : CoinModel, amount : Double){
        
        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        }else {
            add(coin: coin, amount: amount)
        }
        
    }
    
    
    // MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
            
        } catch let error {
            print("Error in geting portfolio: \(error)")
        }
        
    }
    
    
    private func add(coin : CoinModel , amount : Double ){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChange()
    }
    
    private func update(entity : PortfolioEntity , amount : Double){
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity : PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error in saving portfolio: \(error)")
        }
    }
    
    private func applyChange () {
        save()
        getPortfolio()
    }
}
