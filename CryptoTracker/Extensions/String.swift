//
//  String.swift
//  CryptoTracker
//
//  Created by Arkar Min on 19/10/2024.
//

import Foundation

extension String {
    
    var removingHTMLOccurrences: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
