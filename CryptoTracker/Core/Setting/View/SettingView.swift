//
//  SettingView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 19/10/2024.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    
    private var defaultURL = URL(string: "https://www.google.com")!
    private var youtubeURL = URL(string: "https://www.youtube.com")!
    private var coffeeURL = URL(string: "https://www.buymecoffee.com")!
    private var coingeckoURL = URL(string: "https://www.coingecko.com")!
    private var personalURL = URL(string : "https://www.personal.com")!
    
    var body: some View {
        NavigationView {
            List{
                swiftfullThinkingSection
                
                coinGeckoSection
                
                developerSection
                
                applicationSection
                
                
            }
            .font(.headline)
            .accentColor(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: dismiss)
                }
            }
        }
    }
}

#Preview {
    SettingView()
}


extension SettingView {
    private var swiftfullThinkingSection : some View {
        Section(header: Text("SWIFTFUL THINKING")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on Youtube. It uses MVVM architecture, combine and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
                
            }
            .padding(.vertical)
            
            Link(destination: youtubeURL) {
                Text("Subscribe on YouTube ")
            }
            
            Link(destination: coffeeURL) {
                Text("Support his coffee addition ")
            }
        }
        
    }
    
    private var coinGeckoSection : some View {
        Section(header: Text("COINGECKO")) {
            VStack (alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("Cryptocurrency data that is used in this app comes from a free CoinGecko API. Prices may be slightly delayed")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
                
            }
            .padding(.vertical)
            
            Link(destination: coingeckoURL) {
                Text("Visit Coin Gecko")
            }
            
        }
        
    }
    
    private var developerSection : some View {
        Section(header: Text("DEVELOPER")) {
            VStack (alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Arkar Min. It uses SwiftUI and is written 100% in Swift.The project benefit from multithreading , publisher/subscriber , and data persistence")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
                
            }
            .padding(.vertical)
            
            Link(destination: personalURL) {
                Text("Visit Website")
            }
            
        }
        
    }
    
    private var applicationSection : some View {
        Section(header: Text("APPLICATION")) {
            Link(destination: defaultURL) {
                Text("Term of Service")
            }
            Link(destination: defaultURL) {
                Text("Privacy Policy")
            }
            Link(destination: defaultURL) {
                Text("Company Website")
            }
            Link(destination: defaultURL) {
                Text("Learn More")
            }
            
        }
    }
    
    
}
