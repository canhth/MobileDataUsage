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
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

public extension PresenterInterface {
    func viewDidLoad() {
        assertionFailure("Implementation pending...")
    }

    func viewWillAppear(animated: Bool) {
        assertionFailure("Implementation pending...")
    }

    func viewDidAppear(animated: Bool) {
        assertionFailure("Implementation pending...")
    }

    func viewWillDisappear(animated: Bool) {
        assertionFailure("Implementation pending...")
    }

    func viewDidDisappear(animated: Bool) {
        assertionFailure("Implementation pending...")
    }
}
