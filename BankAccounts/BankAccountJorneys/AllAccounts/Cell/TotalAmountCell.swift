//
//  TotalAmountCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class TotalAmountCell: UITableViewCell {
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Total"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
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

    func configure(totalAmount: Double) {
        amountLabel.text = totalAmount.formatted(.currency(code:"RON")
            .locale(Locale(identifier: "fr-FR")))
    }

    private func setupUI() {
        self.addSubview(totalLabel)
        NSLayoutConstraint.activate([
            totalLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            totalLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        self.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
        ])
    }
}
