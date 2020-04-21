//
//  UIFont+Ext.swift
//  MindValley
//
//  Created by Canh Tran Wizeline on 4/9/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

enum SPHFont {
    
    static let headLine = bold(ofSize: 30)
    
    static let section = bold(ofSize: 24)
    
    static let title = regular(ofSize: 18)
    
    static let subTitle = regular(ofSize: 13)
    
    static let numberValue = regular(ofSize: 17)
    
    private static func regular(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize)
    }
      
    private static func bold(ofSize: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: ofSize)
    }
}
