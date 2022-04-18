//
//  RestaurantViewController.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 15/04/22.
//

import UIKit

private typealias TableViewDataSourceMethods = RestaurantViewController

class RestaurantViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var customTableView: UITableView!
    
    //MARK: - Properties
    var restaurantViewModel = RestaurantViewModel()
    var restauratResponse: [Restaurant]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupNavigationBar()
        restauratResponse = restaurantViewModel.readRestaurantDataFromJson()
        customTableView.reloadData()
    }
    
    private func registerCells() {
        customTableView.register(.detailsTableViewCellNib(), forCellReuseIdentifier: AppUtils.Identifiers.restaurantDetailsCellId)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Restaurants"
        let rightBarButtonItem = UIBarButtonItem(title: "Filters", style: .plain, target: self, action: #selector(filterButtonClicked))
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    @objc private func filterButtonClicked() {
        
    }
}


extension TableViewDataSourceMethods: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restauratResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppUtils.Identifiers.restaurantDetailsCellId) as? RestaurantDetailsTableViewCell else { return UITableViewCell() }
        cell.titleLabel.text = restauratResponse?[indexPath.row].name ?? ""
        let type = restauratResponse?[indexPath.row].status
        switch type {
        case .statusOpen:
            cell.statusLabel.text = "Open"
            cell.bgView.backgroundColor = .green
        case .orderAhead:
            cell.statusLabel.text = "Order Ahead"
            cell.bgView.backgroundColor = .orange
        case .statusClosed:
            cell.statusLabel.text = "Closed"
            cell.bgView.backgroundColor = .red
        case .none:
            break
        }
        return cell
    }
}
