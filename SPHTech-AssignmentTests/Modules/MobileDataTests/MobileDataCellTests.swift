//
//  MobileDataCellTests.swift
//  SPHTech-AssignmentTests
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import XCTest
@testable import SPHTech_Assignment

final class MobileDataCellTests: SPHTech_AssignmentTests {
    
    private let quarterRecords = [QuarterRecord(_id: 0, quarter: "Test", volumeOfMobileData: "1.123"),
                                  QuarterRecord(_id: 1, quarter: "Test", volumeOfMobileData: "2.123"),
                                  QuarterRecord(_id: 2, quarter: "Test", volumeOfMobileData: "3.123")]
    
    private let decreaseQuarterRecords = [QuarterRecord(_id: 0, quarter: "Q1", volumeOfMobileData: "2.123"),
                                          QuarterRecord(_id: 1, quarter: "Q2", volumeOfMobileData: "1.123"),
                                          QuarterRecord(_id: 2, quarter: "Q3", volumeOfMobileData: "3.123")]
    
    private var yearRecord = YearRecord(quarter: QuarterRecord(_id: 9, quarter: "Q1", volumeOfMobileData: "1"))
    
    func testCreateQuaterSubViews() {
        let view = QuartersStackView()
        view.createQuarterViews(quarterRecords)
        XCTAssertTrue(!view.arrangedSubviews.isEmpty, "Should add list quarter view as a label.")
    }
    
    func testYearRecordModel() {
        yearRecord.quarterRecords = quarterRecords
        
        XCTAssertTrue(!yearRecord.isDecreasedVolumeData, "This is not a decreased volume data in a year.")
    }
        
    func testDecreasedVolumData() {
        yearRecord.quarterRecords = decreaseQuarterRecords
        XCTAssertTrue(yearRecord.isDecreasedVolumeData, "This is should be a decreased volume data in a year.")
    }
}
