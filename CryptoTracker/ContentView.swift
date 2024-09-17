//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 17/09/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            
            VStack{
                Text("Accent")
                    .foregroundStyle(Color.theme.accent)
                
                Text("green")
                    .foregroundStyle(Color.theme.green)
                
                Text("Accent")
                    .foregroundStyle(Color.theme.red)
                
                Text("Accent")
                    .foregroundStyle(Color.theme.secondaryText)
                
                
            }
            
            
        }
    }
}

#Preview {
    ContentView()
}
