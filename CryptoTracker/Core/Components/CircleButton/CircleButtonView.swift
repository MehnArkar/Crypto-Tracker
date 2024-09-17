//
//  CircleButtonView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 17/09/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName : String
    
    var body: some View {
       Image(systemName:iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width:50,height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.25),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/,
                x: 0,
                y:0
            )
    }
}

#Preview("Correct!", traits: .sizeThatFitsLayout) {
    
    Group {
        CircleButtonView(iconName: "info")
            .padding()
            .previewLayout(.sizeThatFits)
        
        CircleButtonView(iconName: "plus")
            .padding()
            .preferredColorScheme(.dark)
    }
    
   
    
}
