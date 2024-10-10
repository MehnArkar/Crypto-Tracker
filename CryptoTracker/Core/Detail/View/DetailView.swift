//
//  DetailView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 09/10/2024.
//

import SwiftUI

struct DetailLoadingView : View {
    
    @Binding var coin : CoinModel?
    
    var body: some View {
        ZStack{
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private  var vm : DetailViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: MockData.coin)
}
