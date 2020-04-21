//
//  MobileDataCell.swift
//  SPHTech-Assignment
//
//  Created by Canh Tran Wizeline on 4/21/20.
//  Copyright © 2020 Canh Tran. All rights reserved.
//

import UIKit

protocol MobileDataCellDelegate: AnyObject {
    func heighOfCellDidChange()
}

final class MobileDataCell: UITableViewCell {
    
    // MARK: - Private Constraints & UIs
    
    private enum DesignConstraints {
        static let dropDownButtonSize = CGSize(width: 45, height: 25)
        static let stackPadding: CGFloat = 5
    }
    
    weak var delegate: MobileDataCellDelegate?
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = SPHFont.section
        label.textColor = AppColor.white
        return label
    }()
    
    private let dataAmountLabel: UILabel = {
        let label = UILabel()
        label.font = SPHFont.numberValue
        label.textColor = AppColor.white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var dropdownImage = UIImage(named: "dropdown_ic")?.withRenderingMode(.alwaysTemplate)
    
    private lazy var dropDownButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = AppColor.white
        button.anchor(width: DesignConstraints.dropDownButtonSize.width,
                      height: DesignConstraints.dropDownButtonSize.height)
        button.addTarget(self, action: #selector(dropDownButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearLabel,
                                                       dataAmountLabel,
                                                       dropDownButton])
        stackView.axis = .horizontal
        stackView.spacing = DesignConstraints.stackPadding
        yearLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        return stackView
    }()
    
    private lazy var quartersStackView: QuartersStackView = {
        let view = QuartersStackView()
        return view
    }()
    
    private let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoStackView,
                                                       quartersStackView])
        stackView.axis = .vertical
        stackView.spacing = Constraints.paddingX3
        
        return stackView
    }()
    
    // MARK: - Public functions
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        backgroundColor = AppColor.darkBackground
        
        contentView.addSubview(stackView)
        stackView.anchor(top: contentView.topAnchor,
                         left: contentView.leftAnchor,
                         right: contentView.rightAnchor,
                         paddingTop: Constraints.paddingX3,
                         paddingLeft: Constraints.paddingX2,
                         paddingRight: Constraints.paddingX2)
        
//        contentView.addSubview(dropDownButton)
//        dropDownButton.anchor(top: stackView.topAnchor,
//                              left: stackView.rightAnchor,
//                              right: contentView.rightAnchor,
//                              paddingRight: Constraints.basePadding)
        
        contentView.addSubview(separateView)
        separateView.anchor(top: stackView.bottomAnchor,
                            left: contentView.leftAnchor,
                            right: contentView.rightAnchor,
                            paddingTop: Constraints.paddingX3,
                            paddingLeft: Constraints.paddingX2,
                            height: Constraints.lineHeight)
        separateView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -Constraints.basePadding)
            .set(priority: .defaultHigh)
            .set(active: true)
    }
    
    @objc
    private func dropDownButtonClicked() {
        quartersStackView.alpha = quartersStackView.isHidden ? 0 : 1
        
        UIView.animate(withDuration: 0.3) {
            self.quartersStackView.isHidden = !self.quartersStackView.isHidden
            self.quartersStackView.alpha = self.quartersStackView.isHidden ? 0 : 1
        }
        
        delegate?.heighOfCellDidChange()
    }
    
    func configCell(with record: YearRecord) {
        yearLabel.text = record.year
        dataAmountLabel.text = "Total data: \(record.totalVolumeData)"
        dropDownButton.setImage(nil, for: .normal)
        quartersStackView.isHidden = true
        
        if record.isDecreasedVolumeData {
            quartersStackView.createQuarterViews(record.quarterRecords)
            dropDownButton.setImage(dropdownImage, for: .normal)
        } else {
            quartersStackView.cleanupSubViews()
        }
    }
}
