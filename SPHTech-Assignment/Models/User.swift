//
//  User.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
    let url: String?
    let followersUrl: String?
    let followingUrl: String?
    let reposUrl: String?
    let type: String
}
