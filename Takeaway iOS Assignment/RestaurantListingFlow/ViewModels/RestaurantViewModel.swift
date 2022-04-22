//
//  RestaurantViewModel.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 18/04/22.
//

import Foundation

enum SortingFilters: String, CaseIterable {
    case bestMatch, newest, ratingAverage, distance, popularity, averageProductPrice, deliveryCosts, minCost
    
    var sortingTitles: String {
        switch self {
        case .bestMatch:
            return AppUtils.AppConstants.bestMatchString
        case .newest:
            return AppUtils.AppConstants.newestString
        case .ratingAverage:
            return AppUtils.AppConstants.ratingAverageString
        case .distance:
            return AppUtils.AppConstants.distanceString
        case .popularity:
            return AppUtils.AppConstants.popularityString
        case .averageProductPrice:
            return AppUtils.AppConstants.averageProductPriceString
        case .deliveryCosts:
            return AppUtils.AppConstants.deliveryCostsString
        case .minCost:
            return AppUtils.AppConstants.minCostSring
        }
    }
    
    var sortingkeys: String {
        switch self {
        case .bestMatch:
            return AppUtils.AppConstants.bestMatchFilterKey
        case .newest:
            return AppUtils.AppConstants.newestString.lowercased()
        case .ratingAverage:
            return AppUtils.AppConstants.ratingAverageFilterKey
        case .distance:
            return AppUtils.AppConstants.distanceString.lowercased()
        case .popularity:
            return AppUtils.AppConstants.popularityString.lowercased()
        case .averageProductPrice:
            return AppUtils.AppConstants.averageProductPriceFilterKey
        case .deliveryCosts:
            return AppUtils.AppConstants.deliveryCostsFilterKey
        case .minCost:
            return AppUtils.AppConstants.minCostFilterKey
        }
    }
}

class RestaurantViewModel {
    
    //MARK: - Properties
    var responseResult: [Restaurant] = []
    private var sortOptionSelected: SortingFilters?
    
    //MARK: - Closures
    var reloadTableView: (() -> Void)?
    
    //MARK: - Sorting Methods
    func restaurantDataBasedOnSort(with filterOption: SortingFilters) {
        sortOptionSelected = filterOption
        responseResult.sort { $0.sortingValues[filterOption.rawValue] ?? 0.0 > $1.sortingValues[filterOption.rawValue] ?? 0.0 }
        responseResult.sort { $0.status < $1.status }
        self.reloadTableView?()
    }
    
    //MARK: - Binding cell view model
    func restaurantCellViewModel(at indexPath: IndexPath) -> RestaurantCellDataProtocol {
        RestaurantCellViewModel(restaurantData: responseResult[indexPath.row], sortingFilters: sortOptionSelected ?? .bestMatch)
    }
    
    //MARK: - API Calls
    func readRestaurantDataFromJson(fileName: String = AppUtils.AppConstants.jsonFileNameString) {
        guard let filePath = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            return
        }
        do {
            let jsonData = try Data(contentsOf: filePath, options: .mappedIfSafe)
            if let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                let decoder = JSONDecoder()
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                var responseData = try decoder.decode(RestaurantResponseModel.self, from: jsonData)
                let sortedRes = sortRestaurantsOnStatus(responseData: &responseData)
                responseResult = sortedRes.restaurants
                self.reloadTableView?()
            }
        } catch {
            responseResult = []
        }
    }
    
    func numberOfRestaurantsCount() -> Int {
        return responseResult.count
    }
    
    private func sortRestaurantsOnStatus(responseData: inout RestaurantResponseModel) -> RestaurantResponseModel {
        responseData.restaurants.sort { $0.status < $1.status }
        return responseData
    }
    
    //MARK: - Search bar handling methods
    func searchTextEntered(_ text: String) {
        if !text.isEmpty {
            self.responseResult = self.responseResult.filter { $0.name.lowercased().hasPrefix(text.lowercased()) }
        } else {
            readRestaurantDataFromJson()
        }
        self.reloadTableView?()
    }
}
