// 
//  MobileDataViewController.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MobileDataViewController: BaseViewController {
    // MARK: - Public Properties

    var presenter: MobileDataPresenterInterface!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(MobileDataCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = AppColor.darkBackground
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(handleRefresh(_:)),
                                 for: .valueChanged)
        refreshControl.tintColor = AppColor.white
        return refreshControl
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            indicator.style = .medium
        } else {
            indicator.style = .white
        }
        indicator.color = AppColor.white
        return indicator
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }

    // MARK: - Setup

    private func setupView() {
        statusBarStyle = .lightContent
        preferLargeTitleNavigationBar(enable: true, with: "Mobile Data 2008 - 2018")
        
        view.addSubview(tableView)
        tableView.anchor(top: view.layoutMarginsGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor)
        
        view.addSubview(loadingIndicator)
        loadingIndicator.anchorCenter(horizontal: view.centerXAnchor,
                                      vertical: view.centerYAnchor)
        
        tableView.addSubview(refreshControl)
    }
    
    @objc
    private func handleRefresh(_ refreshControl: UIRefreshControl) {
        guard refreshControl.isRefreshing else { return }
        presenter.refreshListData()
    }
}

// MARK: - MobileDataViewInterface

extension MobileDataViewController: MobileDataViewInterface {
    func reloadData() {
        guard !refreshControl.isRefreshing else { return }
        tableView.reloadData()
    }
    
    func setLoadingVisible(_ visible: Bool) {
        loadingIndicator.isHidden = !visible
        if !visible {
            refreshControl.endRefreshing()
            loadingIndicator.stopAnimating()
        } else {
            loadingIndicator.startAnimating()
        }
    }
}

// MARK: - UITableViewDataSource

extension MobileDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfYearRecords()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MobileDataCell = tableView.dequeueReusableCell(for: indexPath)
        if let data = presenter.dataAtIndex(index: indexPath.row) {
            cell.configCell(with: data)
            cell.delegate = self
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MobileDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            presenter.fetchListMobileData()
        }
    }
}

extension MobileDataViewController: MobileDataCellDelegate {
    func heighOfCellDidChange() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
