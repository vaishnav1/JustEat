//
//  RestaurantViewModel.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 18/04/22.
//

import Foundation

class RestaurantViewModel {
    
    //MARK: - API Calls
    internal func readRestaurantDataFromJson() -> [Restaurant] {
        var responseResult: [Restaurant]?
        guard let filePath = Bundle.main.url(forResource: AppUtils.AppConstants.jsonFileNameString, withExtension: "json") else {
            print(AppUtils.ErrorMessages.unableToFindJsonString)
            return []
        }
        do {
            let jsonData = try Data(contentsOf: filePath, options: .mappedIfSafe)
            if let jsonResult = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
                let decoder = JSONDecoder()
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let responseData = try decoder.decode(RestaurantResponseModel.self, from: jsonData)
                responseResult = responseData.restaurants
            }
        } catch {
            responseResult = []
        }
        return responseResult ?? []
    }
}
