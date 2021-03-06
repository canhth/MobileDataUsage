// 
//  MobileDataDependency.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MobileDataDependency: MobileDataDependencyInterface {
    // MARK: - Module Setup

    func makeMobileDataView() -> ViewInterface {
        let view = MobileDataViewController()

        let interactor = MobileDataInteractor()
        let navigationController = UINavigationController()
        let router = MobileDataRouter(rootController: navigationController)
        router.setRootView(view, animated: false)

        let presenter = MobileDataPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter

        return router.toController()
    }
}
