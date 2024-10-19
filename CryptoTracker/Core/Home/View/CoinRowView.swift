//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 18/09/2024.
//

import SwiftUI

struct CoinRowView: View {
    let coin : CoinModel
    let showHoldingColum : Bool
    
    var body: some View {
        HStack{
            leftColum
            
            Spacer()
            
            if showHoldingColum {
               centerColum
            }
            
            rightColum
            
        }
        .font(.subheadline)
        .background(Color.theme.background)
    }
}

#Preview (traits:.sizeThatFitsLayout){
        CoinRowView(coin: MockData.coin,showHoldingColum: true)
}

#Preview (traits:.sizeThatFitsLayout){
        CoinRowView(coin: MockData.coin,showHoldingColum: true)
        .preferredColorScheme(.dark)
}


extension CoinRowView {
    private var leftColum : some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30,height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading,6)
                .foregroundStyle(Color.theme.accent)
        }
        
    }
    
    private var centerColum : some View {
        
        VStack(alignment:.trailing){
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0.0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    
    private var rightColum : some View {
        VStack(alignment:.trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text((coin.priceChangePercentage24H ?? 0.0).asPercentString())
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0.0) > 0
                    ? Color.theme.green
                    : Color.theme.red
                )
        }
        .frame(width:UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
    }
}
