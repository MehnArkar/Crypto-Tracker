//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 17/09/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio : Bool = false
    
    var body: some View {
        ZStack{
            //Background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack{
                homeHeader
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
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden, for: .navigationBar)
    }
    
}
