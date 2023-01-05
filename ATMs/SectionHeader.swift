//
//  SectionHeader.swift
//  ATMs
//
//  Created by Karina Kovaleva on 5.01.23.
//

import UIKit

class SectionHeader: UICollectionReusableView {

    static let reuseId = "sectionHeader"

    lazy var headerLabel: UILabel = {
        var headerLabel = UILabel()
        headerLabel.font = UIFont(name: "Helvetica Neue", size: 20)
        return headerLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        self.addSubview(self.headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
