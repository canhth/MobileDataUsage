//
//  QuarterRecord.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import Foundation

struct QuaterRecord: Decodable {
    let id: Int
    let quater: String
    let volumeOfMobileData: String
    
    var year: String {
        return quater.components(separatedBy: "-").first ?? ""
    }
    
    var quaterName: String {
        return quater.components(separatedBy: "-").last ?? ""
    }
}
