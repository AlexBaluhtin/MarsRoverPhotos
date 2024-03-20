//
//  Color+hex.swift
//  MarsRoverPhotosSwiftUI
//
//  Created by Alex Balukhtsin on 16/03/2024.
//

import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1) {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        // Разбиение строки hex на отдельные компоненты (R, G, B)
        var rgb: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}
