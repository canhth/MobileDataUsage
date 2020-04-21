//
//  MobileNetworkAPI.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import Foundation

enum MobileNetworkEndpoint {
    case fetchListMobileData(limit: Int, offset: Int)
}

// MARK: Confirm protocol Endpoint

extension MobileNetworkEndpoint: APIEndpoint {
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "action/datastore_search"
    }
    
    var parameters: Parameters? {
        switch self {
        case .fetchListMobileData(let limit, let offset):
            return ["resource_id": DefaultNetworkConfiguration.networkConfiguration.resourceId,
                    "limit": limit,
                    "offset": offset]
        }
    }
    
    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
