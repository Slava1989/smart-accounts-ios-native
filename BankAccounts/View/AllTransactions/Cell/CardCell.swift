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

    private lazy var balanceTitleLabel: UILabel = {
        let balance = UILabel()
        balance.text = "Balance"
        balance.textColor = .white
        balance.font = .systemFont(ofSize: 20)
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()

    private lazy var balanceLabel: UILabel = {
        let balance = UILabel()
        balance.textColor = .white
        balance.font = .systemFont(ofSize: 22, weight: .bold)
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()

    private lazy var cardNumberLabel: UILabel = {
        let balance = UILabel()
        balance.textColor = .white
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()

    private lazy var dueDateLabel: UILabel = {
        let balance = UILabel()
        balance.textColor = .white
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(balanceTitleLabel)
        containerView.addSubview(balanceLabel)
        containerView.addSubview(cardNumberLabel)
        containerView.addSubview(dueDateLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            balanceTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            balanceTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),

            balanceLabel.topAnchor.constraint(equalTo: balanceTitleLabel.bottomAnchor, constant: 10),
            balanceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            cardNumberLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 15),
            cardNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),

            dueDateLabel.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 15),
            dueDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        ])
    }

    func configureCell(card: Card) {
//        contentView.backgroundColor = card.color
//        contentView.layer.cornerRadius = 12
//        balanceLabel.text = "\(card.ballance) \(card.currency.simbol)"
//        cardNumberLabel.text = card.numeber
//        dueDateLabel.text = card.expirationDate
    }

}
