//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 23/09/2024.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var vm : CoinImageViewModel
    
    init(coin : CoinModel){
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    
    var body: some View {
        ZStack{
            if  let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundStyle(Color.theme.secondaryText)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(coin: MockData.coin)
        .padding()
}
