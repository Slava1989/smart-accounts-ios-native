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

    private lazy var amountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .trailing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var disclaimerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Suma totala estimativa in RON"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 13)
        label.textColor = .lightGray
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

        amountStackView.addArrangedSubview(amountLabel)
        amountStackView.addArrangedSubview(disclaimerLabel)

        self.addSubview(amountStackView)
        NSLayoutConstraint.activate([
            amountStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            amountStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    func configure(bankAccount: BankAccount) {
        circleView.backgroundColor = UIColor(named: bankAccount.color)
        titleLabel.text = bankAccount.bankNameShort
        disclaimerLabel.isHidden = true

        if bankAccount.currency.rawValue != "RON" {
            disclaimerLabel.isHidden = false
            amountLabel.text = (20.24 * bankAccount.amount).formatted(.currency(code:"RON")
                                        .locale(Locale(identifier: "fr-FR")))
            return
        }

        amountLabel.text = bankAccount.amount.formatted(.currency(code:"RON")
                                    .locale(Locale(identifier: "fr-FR")))

    }
}
