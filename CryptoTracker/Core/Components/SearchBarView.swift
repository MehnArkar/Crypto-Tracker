//
//  SearchBarView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 24/09/2024.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText : String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty
                    ? Color.theme.secondaryText
                    : Color.theme.accent
                )
            
            TextField("Search by name or symbol", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled(true)
                .padding(.trailing, 30)
                .overlay(alignment: .trailing) {
                    
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                
                }
            
            
            
                
        }
        .font(.headline)
        .padding(.all,10)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.accent.opacity(0.15),
                    radius: 20
                )
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .padding()
        .colorScheme(.light)
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .padding()
        .colorScheme(.dark)
}

