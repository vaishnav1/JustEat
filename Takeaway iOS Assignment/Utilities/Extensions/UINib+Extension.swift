//
//  UINib+Extension.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 18/04/22.
//

import Foundation
import UIKit

extension UINib {
    
    class func detailsTableViewCellNib() -> UINib {
        return UINib(nibName: AppUtils.Identifiers.restaurantDetailsCellId, bundle: Bundle.main)
    }
}
