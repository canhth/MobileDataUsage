//
//  MockMobileDataTests.swift
//  SPHTech-AssignmentTests
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import XCTest
@testable import SPHTech_Assignment

final class MockMobileDataInteractor {
    
    private let limit = 20
    private var offset = 0
    private var totalResults = 0
    private let startYear = "2008"
    private let endYear = "2018"
    
    private let networkClient: NetworkRequestable

    // MARK: - LifeCycle

    init(networkClient: NetworkRequestable = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    private func filterQuartersToYearlyRecords(quarters: [QuarterRecord]) -> [YearRecord] {
        var yearRecords = [YearRecord]()
        
        for quarter in quarters {
            // Only input data from 2008 - 2018
            let year = quarter.year
            guard year >= startYear && year <= endYear else { continue }
            
            // Init first value if list isEmpty
            if yearRecords.isEmpty {
                yearRecords.append(YearRecord(quarter: quarter))
                continue
            }
            
            guard var currentYearRecord = yearRecords.last else { continue }
            
            // Init the new YearRecord for the next year
            guard yearRecords.last?.year ?? "" == year else {
                currentYearRecord = YearRecord(quarter: quarter)
                yearRecords.append(currentYearRecord)
                continue
            }
            
            currentYearRecord.quarterRecords.append(quarter)
            
            // ReUpdate the latest value.
            yearRecords[yearRecords.count - 1] = currentYearRecord
        }
        
        return yearRecords
    }
}

extension MockMobileDataInteractor: MobileDataInteractorInterface {
    func cleanUp() {
        offset = 0
        totalResults = 0
    }
    
    func reachedLimit() -> Bool {
        return totalResults != 0 && totalResults <= offset
    }
    
    func fetchListMobileData(isCached: Bool, completion: @escaping (Result<[YearRecord], NetworkError>) -> Void) {
        guard let data = TestSuite().data(fromResource: "mobiledata_page\(offset/limit)", withExtension: "json") else {
            XCTFail("Can not get the data form mobiledata_page\(offset/limit).json")
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let resultData = try decoder.decode(MobileDataResponse.self, from: data)
            let records = resultData.result.records
            totalResults = resultData.result.total
            
            let yearRecords = self.filterQuartersToYearlyRecords(quarters: records)
            completion(.success(yearRecords))
            XCTAssertNotNil(yearRecords, "Should load the list records without error.")
        } catch {
            XCTFail("Can not parse the mobiledata_page\(offset/limit).json")
        }
        offset += limit
    }
}
