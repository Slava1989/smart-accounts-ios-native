//
//  RoundNumberView.swift
//  Breaking-PointWidget
//
//  Created by Veaceslav Chirita on 28.12.2022.
//

import UIKit

class RoundNumberView: UIView {

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    convenience init(frame: CGRect, number: String) {
        self.init(frame: frame)

        numberLabel.text = number
        self.backgroundColor = UIColor(red: 45/255, green: 15/255, blue: 109/255, alpha: 1.0)

        setup()
    }

    private func setup() {
        self.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
