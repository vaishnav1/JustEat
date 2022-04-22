//
//  ViewModelTests.swift
//  Takeaway iOS AssignmentTests
//
//  Created by vaishnav.chidambar on 21/04/22.
//

import XCTest
@testable import Takeaway_iOS_Assignment

class ViewModelTests: XCTestCase {
    
    //MARK: - Properties
    var viewModel: RestaurantViewModel?
    
    override func setUp() {
        viewModel = RestaurantViewModel()
    }
    
    func testReadDataFromJSONWithData() {
        viewModel?.readRestaurantDataFromJson(fileName: "TestSampleData")
        XCTAssertTrue(viewModel?.numberOfRestaurantsCount() == 5)
    }
    
    func testReadDataFromJSONWithEmptyData() {
        viewModel?.readRestaurantDataFromJson(fileName: "TestEmptyData")
        XCTAssertTrue(viewModel?.numberOfRestaurantsCount() == 0)
    }
    
    func testOnSortOption() {
        viewModel?.readRestaurantDataFromJson(fileName: "TestSampleData")
        viewModel?.restaurantDataBasedOnSort(with: .minCost)
        let cellViewModel = viewModel?.restaurantCellViewModel(at: IndexPath(row: 4, section: 0))
        XCTAssertEqual(cellViewModel?.filterOptionValue == "1300.0", true)
    }
    
    /// Search based on name tests
    func testIfThereIsAMatch() {
        viewModel?.readRestaurantDataFromJson(fileName: "TestSampleData")
        viewModel?.searchTextEntered("r")
        XCTAssertTrue(viewModel?.numberOfRestaurantsCount() == 2)
    }
    
    func testIfThereIsNoMatch() {
        viewModel?.readRestaurantDataFromJson(fileName: "TestSampleData")
        viewModel?.searchTextEntered("a")
        XCTAssertTrue(viewModel?.numberOfRestaurantsCount() == 0)
    }
    
    /// If user clicks on cancel, the data needs to be reset
    func testIfCancelIsClicked() {
        viewModel?.readRestaurantDataFromJson(fileName: "TestSampleData")
        viewModel?.searchTextEntered("")
        XCTAssertTrue(viewModel?.numberOfRestaurantsCount() == 5)
    }
    
    /// To de-initialise the reference
    override func tearDown() {
        viewModel = nil
    }
}
