//
//  PokemonViewModel.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-25.
//

import SwiftUI

final class PokemonViewModel: ObservableObject {
    
    func bgColor(forType type: String) -> Color {
        switch type {
        case "normal": return Color(red: 168/255, green: 168/255, blue: 120/255)
        case "fire": return Color(red: 240/255, green: 128/255, blue: 48/255)
        case "water": return Color(red: 104/255, green: 144/255, blue: 240/255)
        case "grass": return Color(red: 120/255, green: 200/255, blue: 80/255)
        case "electric": return Color(red: 248/255, green: 208/255, blue: 48/255)
        case "ice": return Color(red: 152/255, green: 216/255, blue: 216/255)
        case "fighting": return Color(red: 192/255, green: 48/255, blue: 40/255)
        case "poison": return Color(red: 160/255, green: 65/255, blue: 160/255)
        case "ground": return Color(red: 224/255, green: 192/255, blue: 104/255)
        case "flying": return Color(red: 168/255, green: 144/255, blue: 240/255)
        case "psychic": return Color(red: 248/255, green: 88/255, blue: 136/255)
        case "bug": return Color(red: 168/255, green: 184/255, blue: 31/255)
        case "rock": return Color(red: 184/255, green: 160/255, blue: 56/255)
        case "ghost": return Color(red: 112/255, green: 88/255, blue: 152/255)
        case "dark": return Color(red: 112/255, green: 88/255, blue: 72/255)
        case "dragon": return Color(red: 112/255, green: 56/255, blue: 248/255)
        case "steel": return Color(red: 184/255, green: 184/255, blue: 208/255)
        case "fairy": return Color(red: 240/255, green: 182/255, blue: 188/255)
        default: return .gray
        }
    }
    
    func decToFeetInches(_ value: Double) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.numberFormatter.roundingMode = .halfUp
        
        let feetValue = Measurement(value: value, unit: UnitLength.decimeters).converted(to: .feet).value
        let rounded = feetValue.rounded(.towardZero)
        let feet = Measurement(value: rounded, unit: UnitLength.feet)
        let inches = Measurement(value: feetValue - rounded, unit: UnitLength.feet).converted(to: .inches)
        
        return "\(formatter.string(from: feet)) \(formatter.string(from: inches))"
    }
    
    func hgToPounds(_ value: Double) -> String {
        let formatter = MassFormatter()
        formatter.unitStyle = .medium
        formatter.numberFormatter.maximumFractionDigits = 1
        formatter.numberFormatter.roundingMode = .halfUp
        
        let kilograms = Measurement(value: value/10, unit: UnitMass.kilograms)
        let pounds = kilograms.converted(to: .pounds)
        
        return formatter.string(fromValue: pounds.value, unit: .pound)
    }
    
}

extension String {
    func removeDashesAndCapitalize() -> String {
        return self.replacingOccurrences(of: "-", with: " ").capitalized
    }
    func formatGmax() -> String {
        return self.replacingOccurrences(of: "Gmax", with: "G-Max")
    }
}
