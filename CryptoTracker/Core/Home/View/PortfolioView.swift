//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 27/09/2024.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var vm : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var quantityText : String = ""
    @State private var showCheckMark : Bool = false
    

    var body: some View{
        
        NavigationView {
            ScrollView {
                VStack{
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSession()
                    }
                
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: dismiss)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    trailingNavBarButton()
                }
            }
            .onChange(of: vm.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
    
    
    
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel())
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing:10){
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins :  vm.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                updateSelectedCoin(coin: coin)
                            }
                           
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : Color.clear,
                                    lineWidth: 1)
                        )
                        
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private func updateSelectedCoin(coin : CoinModel){
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }){
            if let amount = portfolioCoin.currentHoldings {
                quantityText = String(amount)
            }
        }else {
            quantityText = ""
        }
    }
    
    private func getCurrentCoinValue() -> Double {
        if let  quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private func portfolioInputSession() -> some View {
        VStack(spacing:20){
            
            HStack{
                Text("Current price of \(selectedCoin!.symbol):")
                Spacer()
                Text("\(selectedCoin!.currentPrice)")
            }
            
            Divider()
            
            HStack{
                Text("Amount in your profile")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            Divider()
            
            HStack{
                Text("Current value :")
                Spacer()
                Text(getCurrentCoinValue().asCurrencyWith2Decimals())
            }
            
           
            
            
        }
        
        .padding()
        .animation(.none, value:false)
        .font(.headline)
    }
    
    private func trailingNavBarButton() -> some View {
        HStack{
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1 : 0)
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                
            }
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
            )

        }
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin, let amount = Double(quantityText) else { return }
        
        //save to protfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        
        //showCheckmark
        withAnimation(.easeIn){
            showCheckMark = true
            removeSelectedCoin()
        }
        
        //hide keyboard
        UIApplication.shared.endEditing()
        
        //hive checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut){
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
    }
}
