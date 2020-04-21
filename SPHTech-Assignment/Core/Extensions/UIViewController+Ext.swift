//
//  UIViewController+Ext.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Apply large title for navigation bar
    /// - Parameter title: Navigation title
    func preferLargeTitleNavigationBar(enable: Bool,
                                       with title: String,
                                       displayMode: UINavigationItem.LargeTitleDisplayMode = .automatic) {
        navigationItem.title = title
        navigationController?.navigationBar.barTintColor = AppColor.darkBackground
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: AppColor.lightHeader
        ]
        navigationController?.navigationBar.prefersLargeTitles = enable
        navigationController?.navigationItem.largeTitleDisplayMode = displayMode
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: AppColor.white,
            .font: SPHFont.headLine
        ]
    }
}
