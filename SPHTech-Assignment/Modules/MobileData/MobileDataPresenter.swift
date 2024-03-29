// 
//  MobileDataPresenter.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class MobileDataPresenter {
    // MARK: - Private Properties

    private unowned let view: MobileDataViewInterface
    private let interactor: MobileDataInteractorInterface
    private let router: MobileDataRouterInterface
    
    private var yearRecords = [YearRecord]()
    
    private var loaderStack = [Bool]() {
        didSet {
            view.setLoadingVisible(!loaderStack.isEmpty)
        }
    }

    // MARK: - LifeCycle

    init(view: MobileDataViewInterface,
         interactor: MobileDataInteractorInterface,
         router: MobileDataRouterInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        fetchListMobileData()
    }
    
    private func updateListRecord(_ newRecords: [YearRecord]) {
        defer { view.reloadData() }
        // Set the new list at the beginning.
        guard !yearRecords.isEmpty else {
            yearRecords = newRecords
            return
        }
        
        // Compare the last record with the first new record.
        if let lastYearRecord = yearRecords.last,
            let newYearRecord = newRecords.first,
            lastYearRecord.year == newYearRecord.year {
            
            // Update last record with new data
            yearRecords[yearRecords.count - 1].quarterRecords.append(contentsOf: newYearRecord.quarterRecords)
            yearRecords.append(contentsOf: newRecords[1..<newRecords.count])
            
        } else {
            // Append normally when data is continuously.
            yearRecords.append(contentsOf: newRecords)
        }
        
    }
}

// MARK: - MobileDataPresenterInterface

extension MobileDataPresenter: MobileDataPresenterInterface {
    func numberOfYearRecords() -> Int {
        return yearRecords.count
    }
    
    func dataAtIndex(index: Int) -> YearRecord? {
        return yearRecords[safe: index]
    }
    
    func refreshListData() {
        interactor.cleanUp()
        yearRecords.removeAll()
        fetchListMobileData()
    }
    
    func fetchListMobileData() {
        guard !interactor.reachedLimit() else { return }
        
        loaderStack.append(true)
        
        interactor.fetchListMobileData(isCached: false) { [weak self] (result) in
            guard let self = self else { return }
            
            _ = self.loaderStack.popLast()
            
            switch result {
            case .success(let records):
                self.updateListRecord(records)
                
            case .failure(let error):
                self.router.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
