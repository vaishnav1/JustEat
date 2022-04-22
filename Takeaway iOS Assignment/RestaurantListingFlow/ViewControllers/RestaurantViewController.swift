//
//  RestaurantViewController.swift
//  Takeaway iOS Assignment
//
//  Created by vaishnav.chidambar on 15/04/22.
//

import UIKit

private typealias TableViewDataSourceMethods = RestaurantViewController
private typealias SearchControllerDelegateHandlers = RestaurantViewController

class RestaurantViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var customTableView: UITableView!
    
    //MARK: - Properties
    var restaurantViewModel = RestaurantViewModel()
    private let customSearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
        registerCells()
        restaurantViewModel.readRestaurantDataFromJson()
        initialiseValues()
        reloadTable()
    }
    
    private func initialiseValues() {
        self.restaurantViewModel.restaurantDataBasedOnSort(with: .bestMatch)
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
    
    private func setupSearchBar() {
        customSearchController.searchBar.placeholder = AppUtils.AppConstants.searchRestaurantString
        navigationItem.searchController = customSearchController
        customSearchController.searchBar.delegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = AppUtils.AppConstants.restaurantsString
        let rightBarButtonItem = UIBarButtonItem(title: AppUtils.AppConstants.sortString, style: .plain, target: self, action: #selector(filterButtonClicked))
        self.navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
    }
    
    @objc private func filterButtonClicked() {
        let alertController = UIAlertController(title: "", message: AppUtils.AppConstants.selectToApplyString, preferredStyle: .actionSheet)
        SortingFilters.allCases.forEach({ [weak self] (sortingOption) in
            guard let unwrappedSelf = self else { return }
            alertController.addAction(UIAlertAction(title: sortingOption.sortingTitles, style: .default, handler: { _ in
                unwrappedSelf.restaurantViewModel.restaurantDataBasedOnSort(with: sortingOption)
            }))
        })
        alertController.addAction(UIAlertAction(title: AppUtils.AppConstants.cancelString, style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}


extension TableViewDataSourceMethods: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantViewModel.numberOfRestaurantsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailsTableViewCell.identifier) as? RestaurantDetailsTableViewCell else { return UITableViewCell() }
            let cellViewModel = restaurantViewModel.restaurantCellViewModel(at: indexPath)
            cell.setupData(cellViewModel)
        return cell
    }
}


extension SearchControllerDelegateHandlers: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        restaurantViewModel.searchTextEntered(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        restaurantViewModel.searchTextEntered("")
    }
}
