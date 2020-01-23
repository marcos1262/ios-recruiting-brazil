//
//  EmptyView.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 23/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class EmptyView: UIView, ViewCode {

    lazy var descriptionLabel = UILabel()
        .set(\.textColor, to: .gray)
        .set(\.numberOfLines, to: 0)
        .set(\.font, to: .systemFont(ofSize: 20))

    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setupSubviews() {
        addSubview(descriptionLabel)
    }

    func setupLayout() {
        descriptionLabel
            .anchor(centerX: centerXAnchor)
            .anchor(centerY: centerYAnchor)
    }
}
