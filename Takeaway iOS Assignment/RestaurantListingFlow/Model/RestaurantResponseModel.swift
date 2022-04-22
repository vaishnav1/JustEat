//
//  RestaurantResponseModel.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 15/04/22.
//

import Foundation

// MARK: - Response Model
struct RestaurantResponseModel: Codable {
    var restaurants: [Restaurant]
}
    // MARK: - Restaurant
struct Restaurant: Codable, Equatable {
    let name: String
    let status: Status
    let sortingValues: [String: Double]
    
    // MARK: - SortingValues
    struct SortingValues: Codable {
        let bestMatch, newest: Int
        let ratingAverage: Double
        let distance, popularity, averageProductPrice, deliveryCosts: Int
        let minCost: Int
    }
    
    enum Status: String, Codable, Comparable {
        
        case statusOpen = "open"
        case orderAhead = "order ahead"
        case statusClosed = "closed"
        
        private var statusOrder: Int {
            switch self {
            case .statusOpen:
                return 0
            case .orderAhead:
                return 1
            case .statusClosed:
                return 2
            }
        }
        static func < (lhs: Status, rhs: Status) -> Bool {
            lhs.statusOrder < rhs.statusOrder
        }
    }
}

