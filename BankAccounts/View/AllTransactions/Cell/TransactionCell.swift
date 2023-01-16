//
//  TransactionsCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 05.01.2023.
//

import UIKit

final class TransactionCell: UITableViewCell {

    private lazy var bankTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var accountNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var transactionCategory: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var bankIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])

        containerStackView.addArrangedSubview(bankIcon)
        NSLayoutConstraint.activate([
            bankIcon.widthAnchor.constraint(equalToConstant: 30),
            bankIcon.heightAnchor.constraint(equalToConstant: 30)
        ])

        containerStackView.addArrangedSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(bankTitle)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        descriptionStackView.addArrangedSubview(accountNumber)
        descriptionStackView.addArrangedSubview(transactionCategory)

        containerStackView.addArrangedSubview(amountLabel)
    }

    func config(transaction: Transaction?) {
        guard let transaction = transaction else {
            return
        }
        bankTitle.text = transaction.bankName
        descriptionLabel.text = transaction.descritpion
        accountNumber.text = transaction.iban
        transactionCategory.text = transaction.category.rawValue
        bankIcon.image = UIImage(named: transaction.icon)

        switch transaction.type {
        case .credit:
            amountLabel.textColor = .green
            amountLabel.text = "+ \(transaction.amount.formatted(.currency(code: transaction.currency.rawValue).locale(Locale(identifier: "fr-FR"))))"
        case .debit:
            amountLabel.textColor = .black
            amountLabel.text = "- \(transaction.amount.formatted(.currency(code: transaction.currency.rawValue).locale(Locale(identifier: "fr-FR"))))"
        }
    }

}
