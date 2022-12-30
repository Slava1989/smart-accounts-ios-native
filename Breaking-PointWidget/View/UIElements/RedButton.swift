//
//  RedButton.swift
//  Breaking-PointWidget
//
//  Created by Veaceslav Chirita on 28.12.2022.
//

import UIKit

final class RedButton: UIButton {

    convenience init(frame: CGRect, text: String) {
        self.init(frame: frame)

        setup(with: text)
    }

    private func setup(with text: String) {
        let attributes = NSAttributedString(string: text, attributes: [
            .font: UIFont(name: "Helvetica-Bold", size: 15),
            .foregroundColor: UIColor.white
        ])
        self.setAttributedTitle(attributes, for: .normal)
        self.setTitle(text, for: .normal)
        self.backgroundColor = .red
        self.layer.cornerRadius = 7
    }
}
