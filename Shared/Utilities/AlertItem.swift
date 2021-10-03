//
//  AlertItem.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?
}

enum AlertContext {
    
    static let invalidData = AlertItem(title: Text("Server Error"), message: Text("The data received from the server was invalid. Please try again."))
    static let invalidURL = AlertItem(title: Text("Server Error"), message: Text("There is an error trying to reach the server."))
    static let invalidResponse = AlertItem(title: Text("Server Error"), message: Text("Invalid response from the server. Please try again."))
    static let unableToComplete = AlertItem(title: Text("Server Error"), message: Text("Unable to complete your request at this time. Please check your internet connection."))
    
}

