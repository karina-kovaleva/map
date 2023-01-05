//
//  CollectionViewCell.swift
//  ATMs
//
//  Created by Karina Kovaleva on 3.01.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    let identifier = "atmCell"

    private var font = UIFont(name: "Helvetica Neue", size: 14)

    private lazy var mainStackView: UIStackView = {
        var mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillProportionally
        mainStackView.alignment = .leading
        mainStackView.spacing = 0
        [self.installPlaceLabel,
         self.workTimeLabel,
         self.currencyLabel].forEach { mainStackView.addArrangedSubview($0) }
        return mainStackView
    }()

    private lazy var installPlaceLabel: UILabel = {
        var installPlaceLabel = UILabel()
        installPlaceLabel.font = font
        installPlaceLabel.numberOfLines = 0
        return installPlaceLabel
    }()

    private lazy var workTimeLabel: UILabel = {
        var workTimeLabel = UILabel()
        workTimeLabel.font = font
        workTimeLabel.numberOfLines = 0
        return workTimeLabel
    }()

    private lazy var currencyLabel: UILabel = {
        var currencyLabel = UILabel()
        currencyLabel.font = font
        currencyLabel.numberOfLines = 0
        return currencyLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(mainStackView)
        self.backgroundColor = .systemGreen
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configureCell(model: ATM) {
        self.installPlaceLabel.text = model.installPlace
        self.currencyLabel.text = "Валюта: " + model.currency
        self.workTimeLabel.text = model.workTime
    }
}
