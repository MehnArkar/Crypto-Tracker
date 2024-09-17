//
//  CircleButtonAnimation.swift
//  CryptoTracker
//
//  Created by Arkar Min on 17/09/2024.
//

import SwiftUI

struct CircleButtonAnimation: View {
    @Binding var animate : Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1)
            .animation(animate ? Animation.easeOut(duration: 1.0) : nil,value: animate)
        
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
}
