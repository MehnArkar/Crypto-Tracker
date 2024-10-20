//
//  CoinImageService.swift
//  CryptoTracker
//
//  Created by Arkar Min on 23/09/2024.
//

import Foundation
import Combine
import SwiftUI


class CoinImageService {
    
    @Published var image : UIImage? = nil
    var imageSubscription : AnyCancellable?
    private let coin : CoinModel
    private let fileManager  = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName : String
    
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
        }else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: NetworkingManager.handleCompletion,
                receiveValue: { [weak self] (returnedImage) in
                    guard let self = self ,
                          let downloadImage = returnedImage else{ return }
                    
                    self.image = downloadImage
                    self.imageSubscription?.cancel()
                    self.fileManager.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
                })
    }
    
}
