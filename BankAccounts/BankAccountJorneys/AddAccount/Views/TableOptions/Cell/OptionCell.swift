//
//  OptionCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 04.01.2023.
//

import UIKit

final class OptionCell: UITableViewCell {

    private lazy var optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(optionLabel)
        NSLayoutConstraint.activate([
            optionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            optionLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }

    func config(optionTitle: String) {
        optionLabel.text = optionTitle
    }

}
