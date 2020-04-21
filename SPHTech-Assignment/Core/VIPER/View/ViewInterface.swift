//
//  ViewInterface.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 CanhTran. All rights reserved.

import UIKit

public protocol ViewInterface: AnyObject {
    func toController() -> UIViewController
}

extension UIViewController: ViewInterface {
    public func toController() -> UIViewController {
        return self
    }
}
