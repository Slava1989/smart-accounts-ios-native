//
//  AllTransactionsCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class AllTransactionsCell: UITableViewCell {
    private lazy var allTransactions: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 12)
        label.text = "Vezi toate tranzactiile >"
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
        self.addSubview(allTransactions)
        NSLayoutConstraint.activate([
            allTransactions.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            allTransactions.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
