//
//  BankAccountCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import UIKit

final class BankAccountCell: UITableViewCell {
    private lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
        self.addSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            circleView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 30),
            circleView.heightAnchor.constraint(equalToConstant: 30)
        ])

        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 20)
        ])

        self.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    func configure(bankAccout: BankAccount) {
        circleView.backgroundColor = UIColor(named: bankAccout.color)
        titleLabel.text = bankAccout.bankNameShort
        amountLabel.text = bankAccout.amount.formatted(.currency(code:"RON")
                                    .locale(Locale(identifier: "fr-FR")))
    }
}
