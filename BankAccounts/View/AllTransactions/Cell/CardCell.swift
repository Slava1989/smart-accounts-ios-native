//
//  CardCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import UIKit

class CardCell: UICollectionViewCell {
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var bankTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var bankAccountNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var accountBalanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var nameHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Nume"
        label.font = UIFont(name: "Helvetica", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accountNumberHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Numar cont"
        label.font = UIFont(name: "Helvetica", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accountNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var balanceHeaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Balanta"
        label.font = UIFont(name: "Helvetica", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        containerView.addSubview(bankTitleLabel)
        NSLayoutConstraint.activate([
            bankTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            bankTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])

        containerView.addSubview(nameStackView)
        nameStackView.addArrangedSubview(nameHeaderLabel)
        nameStackView.addArrangedSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: bankTitleLabel.bottomAnchor, constant: 20),
            nameStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])

        containerView.addSubview(bankAccountNumberStackView)
        bankAccountNumberStackView.addArrangedSubview(accountNumberHeaderLabel)
        bankAccountNumberStackView.addArrangedSubview(accountNumberLabel)

        NSLayoutConstraint.activate([
            bankAccountNumberStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 20),
            bankAccountNumberStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])

        containerView.addSubview(accountBalanceStackView)
        accountBalanceStackView.addArrangedSubview(balanceHeaderLabel)
        accountBalanceStackView.addArrangedSubview(balanceLabel)

        NSLayoutConstraint.activate([
            accountBalanceStackView.topAnchor.constraint(equalTo: bankAccountNumberStackView.bottomAnchor, constant: 20),
            accountBalanceStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
    }

    func configureCell(bankAccount: BankAccount) {
        let card = bankAccount.card

        bankTitleLabel.text = bankAccount.bankName
        nameLabel.text = card.name

        contentView.backgroundColor = UIColor(named: bankAccount.color)
        contentView.layer.cornerRadius = 12
        accountNumberLabel.text = card.acountNumber
        let amount = bankAccount.amount.formatted(.currency(code: bankAccount.currency.rawValue)
                                   .locale(Locale(identifier: "fr-FR")))

        balanceLabel.text = "\(amount)"
    }
}
