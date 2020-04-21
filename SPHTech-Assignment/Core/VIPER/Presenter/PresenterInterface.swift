//
//  PresenterInterface.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import Foundation

public protocol PresenterInterface: AnyObject {
    func viewDidLoad()
}

public extension PresenterInterface {
    func viewDidLoad() { }
}
