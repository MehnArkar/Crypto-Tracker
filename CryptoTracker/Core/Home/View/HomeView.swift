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
    
    var body: some View {
        ZStack{
            //Background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack{
                homeHeader
                
                HomeStatisticView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                    .padding()
                
                columnTitles
                
                if(!showPortfolio){
                    allCoinsList
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
            
        }
    }
}


extension HomeView {
    private var homeHeader : some View {
        HStack{
            ZStack(alignment: .center){
                CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                    .animation(nil, value: showPortfolio)
                    
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
            }
            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList : some View{
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColum: true)
            }
            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitles : some View{
        HStack{
            Text("Coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
           
            Text("Refresh")
                .frame(width:UIScreen.main.bounds.width / 3.5 , alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden, for: .navigationBar)
    }
    .environmentObject(HomeViewModel())
    
}
