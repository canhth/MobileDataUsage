//
//  MobileDataUITests.swift
//  SPHTech-AssignmentUITests
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import XCTest

final class MobileDataUITests: BaseUITest {
    
    // MARK: - Base functions
    func scrollTableViewToLoadMore(tableView: XCUIElement) {
        waitUntilElementExists(tableView)
        tableView.swipeUp()
        sleep(3)
        XCTAssertTrue(tableView.cells.count >= 10, "Number of cell should be more than 10")
    }
    
    // MARK: - Test cases
    
    func testLoadListMobileDataSuccess() {
        let tableView = app.tables.firstMatch
        
        scrollTableViewToLoadMore(tableView: tableView)
    }
    
    func testRefreshControl() {
        let tableView = app.tables.firstMatch
        let firstCell = tableView.cells.firstMatch
        
        let coordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let bottom = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 10))
        coordinate.press(forDuration: 0, thenDragTo: bottom)
        
        sleep(2)
        
        XCTAssertTrue(tableView.cells.count >= 1, "Should reload list data.")
    }
    
    func testOpenDropDownMenu() {
        // Wait to load list in table view success first
        let tableView = app.tables.firstMatch
        waitUntilElementExists(tableView)
        
        let predicate = NSPredicate(format: "isEnabled = 1")
        let dropdownButton = tableView.cells.buttons.matching(predicate).firstMatch
        
        waitUntilElementExists(dropdownButton)
        
        XCTAssertTrue(dropdownButton.isEnabled, "Button must be exist and enabled.")
        
        dropdownButton.tap()
    }
}
