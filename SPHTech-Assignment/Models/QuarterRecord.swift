//
//  QuarterRecord.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import Foundation

struct QuarterRecord: Decodable {
    let _id: Int
    let quarter: String
    let volumeOfMobileData: String
    
    var year: String {
        return quarter.components(separatedBy: "-").first ?? "2008"
    }
    
    var quarterName: String {
        return quarter.components(separatedBy: "-").last ?? "Q1"
    }
}
