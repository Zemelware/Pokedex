//
//  NetworkError.swift
//  Pokemon
//
//  Created by Ethan Zemelman on 2021-09-22.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidURL
    case invalidResponse
}
