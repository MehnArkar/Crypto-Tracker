//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Arkar Min on 27/09/2024.
//

import SwiftUI

struct XMarkButton: View {
    
    var dismiss: DismissAction
    
    var body: some View {
        
        Button {
            print("Dismiss clicked")
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
        



    }
}

