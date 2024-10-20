//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 17/09/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioSheet : Bool = false
    
    @State private var showSettingSheet : Bool = false
    
    @State private var selectedCoin : CoinModel? = nil
    @State private var isShowDetailView : Bool = false

    
    var body: some View {
        ZStack{
            //Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioSheet) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            //content layer
            VStack{
                homeHeader
                
                HomeStatisticView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if(!showPortfolio){
                    allCoinsList
                        .transition(.move(edge: .leading))
                } else {
                    
                    ZStack{
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            portfolioEmptyText
                        } else {
                            portfolioCoinsList
                        }
                    }
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
            .sheet(isPresented: $showSettingSheet) {
                SettingView()
            }
            
        }
        .background {
            
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $isShowDetailView,
                label: {EmptyView()})
            
        }
    }
}


extension HomeView {
    private var homeHeader : some View {
        HStack{
            ZStack(alignment: .center){
                CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                    .animation(nil, value: showPortfolio)
                    .onTapGesture {
                        if showPortfolio {
                            showPortfolioSheet.toggle()
                        }else {
                            showSettingSheet.toggle()
                        }
                    }
                    
                CircleButtonAnimation(animate: $showPortfolio)
                    .frame(width: 50,height: 50)
            }
            
                
            
            Spacer()
            
            Text(showPortfolio ? "Portfolio" :"Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
                .animation(nil,value: showPortfolio)
            
            Spacer()
            
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: (showPortfolio ? 180 : 0)))
                .onTapGesture {
                    withAnimation (.spring){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList : some View{
        List{
            ForEach(vm.allCoins){ coin in
                
                CoinRowView(coin: coin, showHoldingColum: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                    .listRowBackground(Color.theme.background)
            }
            
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList : some View{
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColum: true)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            .listRowBackground(Color.theme.background)
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin : CoinModel){
        selectedCoin = coin
        isShowDetailView = true
    }
    
    private var columnTitles : some View{
        HStack{
            
            HStack {
                Text("Coins")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .rank || vm.sortOption == .rankRevrsed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rankRevrsed ? .rank : .rankRevrsed
                }
                
                
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(vm.sortOption == .holdings || vm.sortOption == .holdingReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingReversed : .holdings
                    }
                    
                    
                }
            }
           
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity(vm.sortOption == .price || vm.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
                .frame(width:UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                    }
                    
                    
                }
            
            Button{
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            }label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees:vm.isLoading ? 360 : 0), anchor: .center)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
    private var portfolioEmptyText : some View{
        Text("You haven't added coins to your portfolio yet. Click the '+' button to add some")
            .font(.callout)
            .foregroundStyle(Color.theme.accent)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(50)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden, for: .navigationBar)
    }
    .environmentObject(HomeViewModel())
    
}
