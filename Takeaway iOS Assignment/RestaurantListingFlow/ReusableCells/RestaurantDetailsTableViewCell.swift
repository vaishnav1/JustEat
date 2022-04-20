//
//  RestaurantDetailsTableViewCell.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 18/04/22.
//

import UIKit

class RestaurantDetailsTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtTitleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    func setupData(_ cellViewModel: RestaurantCellViewModel) {
        self.titleLabel.text = cellViewModel.restaurantName
        self.statusLabel.text = cellViewModel.status.rawValue.capitalized
        self.subtTitleLabel.text = cellViewModel.totalValue
        
        switch cellViewModel.status {
        case .statusOpen:
            self.bgView.backgroundColor = .green.withAlphaComponent(0.5)
        case .orderAhead:
            self.bgView.backgroundColor = .orange.withAlphaComponent(0.5)
        case .statusClosed:
            self.bgView.backgroundColor = .red.withAlphaComponent(0.5)
        }
    }
}
