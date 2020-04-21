//
//  NetworkClientTests.swift
//  SPHTech-AssignmentTests
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import XCTest
@testable import SPHTech_Assignment

final class NetworkClientTests: SPHTech_AssignmentTests {
    
    private let networkClient = NetworkClient()
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: Mocks
    
    func testMockFetchListMobileData() {
        guard let data = TestSuite().data(fromResource: "mobiledata_page0", withExtension: "json") else {
            XCTFail("Can not get the data form mobiledata_page0.json")
            return
        }
        
        do {
            let resultData = try decoder.decode(MobileDataResponse.self, from: data)
            let records = resultData.result.records
            XCTAssertNotNil(records, "Should load the list records without error.")
        } catch {
            XCTFail("Can not parse the mobiledata_page0.json")
        }
    }
    
    func testMockFetchListMobileDataWithError() {
        guard let data = TestSuite().data(fromResource: "mobiledata_error", withExtension: "json") else {
            XCTFail("Can not get the data form mobiledata_error.json")
            return
        }
        
        do {
            let resultData = try decoder.decode(MobileDataResponse.self, from: data)
            let records = resultData.result.records
            XCTAssertTrue(records.isEmpty, "List records should be empty.")
        } catch {
            XCTFail("Can not parse the mobiledata_error.json")
        }
    }
    
    // MARK: Network
    
    func testFetchListMobileData() {
        let expect = expectation(description: "test_listdata_by_network")
        
        var records = [QuarterRecord]()
        networkClient.fetch(endPoint: MobileNetworkEndpoint.fetchListMobileData(limit: 20,
                                                                                offset: 20),
                            type: MobileDataResponse.self,
                            loadFromCache: false) { (response) in
                                switch response {
                                case .success(let data):
                                    records = data.result.records
                                case .failure(let error):
                                    XCTFail("Fetching data errored: \(error)")
                                }
                                expect.fulfill()
        }
        
        waitForExpectations(timeout: limitTimeOut) { [unowned self] error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            } else {
                XCTAssertTrue(!records.isEmpty, "Should load all the records probably.")
                self.testFetchListMobileDataFromCache()
            }
        }
    }
    
    func testFetchListMobileDataFromCache() {
        networkClient.fetch(endPoint: MobileNetworkEndpoint.fetchListMobileData(limit: 20,
                                                                                offset: 20),
                            type: MobileDataResponse.self,
                            loadFromCache: true) { (response) in
                                switch response {
                                case .success(let data):
                                    XCTAssertTrue(!data.result.records.isEmpty, "Should load all the records from cache probably.")
                                case .failure(let error):
                                    XCTFail("Fetching from cache errored: \(error)")
                                }
        }
    }
    
    func testNetworkErrorStatusCode() {
        
        let expect = expectation(description: "test_error_by_network")
        
        networkClient.fetch(endPoint: ErrorEndpoint.errorRequest,
                            type: QuarterRecord.self,
                            loadFromCache: false) { (response) in
                                switch response {
                                case .success:
                                    XCTFail("This request shoud be failed.")
                                case .failure(let error):
                                    XCTAssertTrue(error.localizedDescription == NetworkError.noSuccessResponse(code: "404").localizedDescription, "Should return invalid response.")
                                }
                                expect.fulfill()
        }
        
        waitForExpectations(timeout: limitTimeOut * 2) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}



