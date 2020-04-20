//
//  ViewRouter.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

class ViewRouter: NSObject, ViewRouterInterface {

    private unowned let rootController: UIViewController

    init(rootController: UIViewController) {
        self.rootController = rootController
        super.init()
        Logger.shared.verbose(object: "Init viewRowter: \(typeName)")
    }

    deinit {
        Logger.shared.verbose(object: "Deinit viewRowter: \(typeName)")
    }

    func toController() -> UIViewController {
        return rootController
    }
}
