// 
//  MobileDataInterfaces.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

// Dependency
protocol MobileDataDependencyInterface {
    func makeMobileDataView() -> ViewInterface
}

// Router
protocol MobileDataRouterInterface: NavigationRouterInterface {
}

// ViewController
protocol MobileDataViewInterface: ViewInterface {
    func reloadData()
    func setLoadingVisible(_ visible: Bool)
}

// Presenter
protocol MobileDataPresenterInterface: PresenterInterface {
    func numberOfYearRecords() -> Int
    func dataAtIndex(index: Int) -> YearRecord?
    func refreshListData()
    func fetchListMobileData()
}

// Interactor
protocol MobileDataInteractorInterface {
    func cleanUp()
    func reachedLimit() -> Bool
    func fetchListMobileData(isCached: Bool, completion: @escaping (Result<[YearRecord], NetworkError>) -> Void)
}
