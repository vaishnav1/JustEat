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
        setupNavigationBar()
        registerCells()
        restauratResponse = restaurantViewModel.readRestaurantDataFromJson()
        initialiseValues()
        reloadTable()
    }
    
    private func initialiseValues() {
        self.restaurantViewModel.restaurantDataBasedOnSort(with: .bestMatch)
        self.customTableView.reloadData()
    }
    
    private func registerCells() {
        customTableView.register(.detailsTableViewCellNib(), forCellReuseIdentifier: RestaurantDetailsTableViewCell.identifier)
    }
    
    private func reloadTable() {
        restaurantViewModel.reloadTableView = { [weak self] in
            guard let unwrappedSelf = self else { return }
            DispatchQueue.main.async {
                unwrappedSelf.customTableView.reloadData()
            }
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = AppUtils.AppConstants.restaurantsString
        let rightBarButtonItem = UIBarButtonItem(title: AppUtils.AppConstants.sortString, style: .plain, target: self, action: #selector(filterButtonClicked))
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    @objc private func filterButtonClicked() {
        let alertController = UIAlertController(title: "Custom Sorting Options", message: "Please select to apply", preferredStyle: .actionSheet)
        SortingFilters.allCases.forEach({ [weak self] (sortingOption) in
            guard let unwrappedSelf = self else { return }
            alertController.addAction(UIAlertAction(title: sortingOption.sortingTitles, style: .default, handler: { _ in
                unwrappedSelf.restaurantViewModel.restaurantDataBasedOnSort(with: sortingOption)
                unwrappedSelf.restaurantViewModel.reloadTableView?()
            }))
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}


extension TableViewDataSourceMethods: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restauratResponse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailsTableViewCell.identifier) as? RestaurantDetailsTableViewCell else { return UITableViewCell() }
        if let restaurantData = restaurantViewModel.responseResult?[indexPath.row] {
            let cellViewModel = RestaurantCellViewModel(restaurantData: restaurantData, sortingFilters: <#SortingFilters#>)
            cell.setupData(cellViewModel)
        }
        return cell
    }
}
