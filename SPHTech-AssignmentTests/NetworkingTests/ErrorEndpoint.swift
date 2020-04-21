//
//  ErrorEndpoint.swift
//  SPHTech-AssignmentTests
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import Foundation
@testable import SPHTech_Assignment

enum ErrorEndpoint {
    case errorRequest
}

// MARK: Confirm protocol Endpoint

extension ErrorEndpoint: APIEndpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "action/datastore_search/error"
    }
    
    var parameters: Parameters? {
        return nil
    }
}
