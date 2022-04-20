//
//  RestaurantCellViewModel.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 18/04/22.
//

import Foundation

protocol RestaurantCellDataProtocol {
    var restaurantName: String { get }
    var filterOption: String { get }
    var status: Restaurant.Status { get }
    var filterOptionValue: String { get }
}

class RestaurantCellViewModel: RestaurantCellDataProtocol {
    
    //MARK: - Properties
    private let restaurantData: Restaurant
    private let sortingFilters: SortingFilters
    
    init(restaurantData: Restaurant, sortingFilters: SortingFilters) {
        self.restaurantData = restaurantData
        self.sortingFilters = sortingFilters
    }
    
    var restaurantName: String { restaurantData.name }
    var filterOptionValue: String { restaurantData.sortingValues[sortingFilters.sortingkeys]?.description ?? "" }
    var status: Restaurant.Status { restaurantData.status }
    var filterOption: String { sortingFilters.sortingTitles }
    var totalValue : String { filterOption + "-> " + filterOptionValue }
}
