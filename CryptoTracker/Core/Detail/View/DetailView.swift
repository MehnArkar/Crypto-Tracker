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
    @State private var showFullDescription : Bool = false
    
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    private let spacing : CGFloat = 20
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack{
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                
                VStack(spacing:20){
                    
                    overviewTitle
                    
                    Divider()
                    
                    descriptionSection
                    
                    overviewGrid
                    
                    additionalTitle
                    
                    Divider()
                    
                    additionalGrid
                    
                    websiteSection
                    
                }
            }
        }
        .navigationTitle(vm.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTraillingItem
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(coin: MockData.coin)
    }
    
}


extension DetailView {
    
    private var navigationBarTraillingItem : some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width:25,height: 25)
        }
    }
    
    private var overviewTitle : some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
    }
    
    private var descriptionSection : some View {
        ZStack{
            if let coinDecription = vm.coinDescription, !coinDecription.isEmpty {
                VStack(alignment:.leading){
                    Text(coinDecription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                    
                    
                    Button{
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }label: {
                        Text( showFullDescription ? "Less" : "Read more...")
                            .font(.caption)
                            .bold()
                            .padding(.vertical,4)
                        
                    }
                    .accentColor(Color.blue)
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
    
    private var additionalTitle : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal)
    }
    
    private var overviewGrid : some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(vm.overviewStatistics){ stat in
                StatisticView(stat: stat)
            }
        }
        .padding(.horizontal)
    }
    
    private var additionalGrid : some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing
        ) {
            ForEach(vm.additionalStatistics){ stat in
                StatisticView(stat: stat)
            }
        }
        .padding(.horizontal)
    }
    
    private var websiteSection : some View {
        VStack(alignment: .leading, spacing: 10){
            
            if let websiteString = vm.websiteURL,
               let url = URL(string: websiteString){
                Link(destination: url){
                    Text("Website")
                }
            }
            
            if let websiteString = vm.redditURL,
               let url = URL(string: websiteString){
                Link(destination: url){
                    Text("Reddit")
                }
            }
            
            
        }
        .frame(maxWidth:.infinity, alignment: .leading)
        .padding(.horizontal)
        .font(.headline)
        .accentColor(.blue)
    }
}
