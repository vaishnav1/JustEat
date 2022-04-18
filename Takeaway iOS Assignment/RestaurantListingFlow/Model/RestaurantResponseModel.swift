//
//  RestaurantResponseModel.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 15/04/22.
//

import Foundation

// MARK: - Welcome
struct RestaurantResponseModel: Codable {
    let restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let name: String
    let status: Status
    let sortingValues: SortingValues
}

// MARK: - SortingValues
struct SortingValues: Codable {
    let bestMatch, newest: Int
    let ratingAverage: Double
    let distance, popularity, averageProductPrice, deliveryCosts: Int
    let minCost: Int
}

enum Status: String, Codable {
    case statusClosed = "closed"
    case orderAhead = "order ahead"
    case statusOpen = "open"
}
