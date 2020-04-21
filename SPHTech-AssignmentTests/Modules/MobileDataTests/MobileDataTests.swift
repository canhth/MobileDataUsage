//
//  MobileDataTests.swift
//  SPHTech-AssignmentTests
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import XCTest
@testable import SPHTech_Assignment

final class MobileDataTests: SPHTech_AssignmentTests {
    
    private let viewController = MobileDataViewController()
    private let interactor = MobileDataInteractor()
    private let router = MobileDataRouter(rootController: UINavigationController())
    private lazy var presenter = MobileDataPresenter(view: viewController,
                                                     interactor: interactor,
                                                     router: router)
    
    override func setUp() {
        super.setUp()
        viewController.presenter = presenter
    }
    
    /// Test Presenter gets list data by network
    func testFetchingDataByNetwork() {
        let expect = expectation(description: "test_mobiledata_by_network")
        
        presenter.fetchListMobileData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + limitTimeOut - 1) {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: limitTimeOut) { [unowned self] error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            } else {
                XCTAssertTrue(self.presenter.numberOfYearRecords() > 0, "Should load at least 1 year record.")
                self.interactor.cleanUp()
                self.loadDataFromLocal()
            }
        }
    }
    
    /// Test Presenter gets list data by Mock data
    func testFetchingDataByMockData() {
        let mockInteractor = MockMobileDataInteractor()
        presenter = MobileDataPresenter(view: viewController,
                                        interactor: mockInteractor,
                                        router: MobileDataRouter(rootController: UINavigationController()))
        viewController.presenter = presenter
        
        presenter.fetchListMobileData()
        
        let numberOfYearRecords = presenter.numberOfYearRecords()
        
        XCTAssertTrue(numberOfYearRecords > 0, "Should load at least 1 year record.")
        
        Logger.shared.info(object: "Trying to fetch next page....")
        presenter.fetchListMobileData()
        XCTAssertTrue(presenter.numberOfYearRecords() > numberOfYearRecords, "Should load at more records succesfully.")
    }
    
    // Test pull to reload page
    func testReloadPage() {
        presenter.refreshListData()
        XCTAssertTrue(presenter.numberOfYearRecords() == 0, "Should clean up everything.")
        
        let expect = expectation(description: "test_reloadData_by_network")
        DispatchQueue.main.asyncAfter(deadline: .now() + limitTimeOut - 1) {
            expect.fulfill()
        }
        
        waitForExpectations(timeout: limitTimeOut) { [unowned self] error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            } else {
                XCTAssertTrue(self.presenter.numberOfYearRecords() > 0, "Should reload after pulldown to refresh.")
            }
        }
    }
    
    // MARK: Privates nested tests
    
    // Load data from local
    private func loadDataFromLocal() {
        interactor.fetchListMobileData(isCached: true) { (result) in
            switch result {
            case .success(let records):
                XCTAssertFalse(records.isEmpty, "Should load data from cache perfectly.")
            case .failure(let error):
                XCTFail("Can not load data from cache \(error)")
            }
        }
    }
}
