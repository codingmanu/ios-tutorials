//
//  CellStack.swift
//  Tutorial-01
//
//  Created by Manuel S. Gomez on 9/2/19.
//  Copyright © 2019 codingManu. All rights reserved.
//

import UIKit

class CellStack: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeStack()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func customizeStack() {
        axis = .vertical
        distribution = .fillProportionally
        spacing = 10.0
        alignment = .fill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
