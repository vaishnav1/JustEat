//
//  ResponseModelTests.swift
//  Takeaway iOS AssignmentTests
//
//  Created by vaishnav.chidambar on 22/04/22.
//

import XCTest
@testable import Takeaway_iOS_Assignment

class ResponseModelTests: XCTestCase {
    
     func testReadDataFromJSON() {
        
        let dataToTest: [Restaurant] = [
            Restaurant(name: "Tanoshii Sushi", status: .statusOpen, sortingValues: [:]),
            Restaurant(name: "Tandoori Express", status: .statusClosed, sortingValues: [:]),
            Restaurant(name: "Royal Thai", status: .orderAhead, sortingValues: [:]),
            Restaurant(name: "Sushi One", status: .statusOpen, sortingValues: [:]),
            Restaurant(name: "Roti Shop", status: .statusOpen, sortingValues: [:])]
        do {
            let actualJsonData: Data = try JSONEncoder().encode(dataToTest)
            let decoder = JSONDecoder()
            let restaurantsModel: [Restaurant] = try decoder.decode([Restaurant].self, from: actualJsonData)
            XCTAssertEqual(restaurantsModel, dataToTest)
        } catch {
            XCTFail("Data mismatch")
        }
    }
    
    func testReadEmptyDataFromJSON() {
        let invalidData = ["This is not expected data": "00"]
        do {
            let actualJsonData: Data = try JSONEncoder().encode(invalidData)
            let decoder = JSONDecoder()
            let _: [Restaurant] = try decoder.decode([Restaurant].self, from: actualJsonData)
            XCTFail("Oh no!")
        } catch {
            XCTAssert(true)
        }
    }
}
