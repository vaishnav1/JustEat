//
//  AppUtils.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 15/04/22.
//

import Foundation

struct AppUtils {
    struct AppConstants {
        //Misc
        static let jsonFileNameString = "takeawayexample"
        
        //FilterStrings
        static let bestMatchString = "Best Match"
        static let newestString = "Newest"
        static let ratingAverageString = "Average Rating"
        static let distanceString = "Distance"
        static let popularityString = "Popularity"
        static let averageProductPriceString = "Average Product Price"
        static let deliveryCostsString = "Delivery Costs"
        static let minCostSring = "Minimum Cost"
        
        //FilterKeyStrings
        static let bestMatchFilterKey = "bestMatch"
        static let ratingAverageFilterKey = "ratingAverage"
        static let averageProductPriceFilterKey = "averageProductPrice"
        static let deliveryCostsFilterKey = "deliveryCosts"
        static let minCostFilterKey = "minCost"
        
        //TitleString
        static let restaurantsString = "Restaurants"
        static let sortString = "Sort"
        static let searchRestaurantString = "Search desired restaurants"
    }
    
    struct ErrorMessagesStrings {
        static let unableToFindJson = "Unable to find the specified JSON file."
    }
}
