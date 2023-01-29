//
//  BankCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class BankCell: UITableViewCell {

    private lazy var bankImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var bankTitleLabel: UILabel = {
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
        self.addSubview(bankImage)
        NSLayoutConstraint.activate([
            bankImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            bankImage.widthAnchor.constraint(equalToConstant: 40),
            bankImage.heightAnchor.constraint(equalToConstant: 40),
            bankImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        self.addSubview(bankTitleLabel)
        NSLayoutConstraint.activate([
            bankTitleLabel.leadingAnchor.constraint(equalTo: self.bankImage.trailingAnchor, constant: 20),
            bankTitleLabel.centerYAnchor.constraint(equalTo: bankImage.centerYAnchor)
        ])
    }

    func config(bank: Bank) {
        bankImage.image = UIImage(named: bank.imageName)
        bankTitleLabel.text = bank.name
    }
}
