//
//  YearRecord.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import Foundation

struct YearRecord {
    
    let year: String
    var totalVolumeData: Float = 0
    var isDecreasedVolumeData: Bool = false
    
    var quarterRecords: [QuarterRecord] {
        didSet {
            let volumeData = quarterRecords.compactMap( { Float($0.volumeOfMobileData) })
            totalVolumeData = volumeData.reduce(0, +)
            isDecreasedVolumeData = !volumeData.isAscending() && volumeData.count > 1
        }
    }
    
    init(quarter: QuarterRecord) {
        year = quarter.year
        totalVolumeData = Float(quarter.volumeOfMobileData) ?? 0
        
        quarterRecords = [quarter]
    }
}
