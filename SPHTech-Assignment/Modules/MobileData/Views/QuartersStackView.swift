//
//  QuartersStackView.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import UIKit

final class QuartersStackView: UIStackView {
    
    private func quarterLabel() -> UILabel {
        let label = UILabel()
        label.font = SPHFont.subTitle
        label.textColor = AppColor.white
        return label
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = Constraints.basePadding / 2
    }
    
    func createQuarterViews(_ quarters: [QuarterRecord]) {
        cleanupSubViews()
        
        quarters.forEach { quarter in
            let label = quarterLabel()
            label.text = "\(quarter.quarterName): \(quarter.volumeOfMobileData)"
            
            addArrangedSubview(label)
        }
    }
    
    func cleanupSubViews() {
        // Try to remove all the subview before setup the new views
        arrangedSubviews.filter({ $0 is UILabel })
            .forEach({ $0.removeFromSuperview() })
    }
    
}
