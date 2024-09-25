//
//  HomeStatisticView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 25/09/2024.
//

import SwiftUI

struct HomeStatisticView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var showPortfolio : Bool

    
    var body: some View {
        HStack{
            ForEach(vm.statistics){ stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width , alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatisticView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
