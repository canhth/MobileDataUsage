//
//  MobileDataResponse.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import Foundation

struct MobileDataResponse: Decodable {
    let help: String
    let success: Bool
    let result: MobileDataResult
}

struct MobileDataResult: Decodable {
    let records: [QuarterRecord]
    let total: Int
}
