//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Arkar Min on 24/09/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
