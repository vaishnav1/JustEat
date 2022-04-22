//
//  DataHandler.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 22/04/22.
//

import Foundation

protocol RestaurantDataGetter {
    func restaurantsData() -> [Restaurant]
}

struct DataHandler: RestaurantDataGetter {
        
    //MARK: - Properties
    private let fileName: String
    private let bundle: Bundle
    
    init(fileName: String = AppUtils.AppConstants.jsonFileNameString, bundle: Bundle = Bundle.main) {
        self.fileName = fileName
        self.bundle = bundle
    }
    
    //MARK: - Getdata methods
    func restaurantsData() -> [Restaurant] {
        guard let filePath = bundle.path(forResource: self.fileName, ofType: "json") else {
            return []
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let responseData = try decoder.decode(RestaurantResponseModel.self, from: jsonData)
            return responseData.restaurants
        } catch {
            return []
        }
    }
}
