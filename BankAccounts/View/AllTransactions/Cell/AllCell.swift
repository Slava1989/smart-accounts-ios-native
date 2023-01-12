//
//  AllCell.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 09.01.2023.
//

import UIKit

final class AllCell: UICollectionViewCell {
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Se afiseaza acum"
        label.textColor = UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1)
        label.font = UIFont(name: "Helvetica", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var subHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Toate conturile"
        label.textColor = UIColor(red: 103/255, green: 103/255, blue: 103/255, alpha: 1)
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var footerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1)
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 12)
        label.text = "Daca doresti sa vezi toate tranzactiile dintr-un cont anume, alege un card din dreapta"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.backgroundColor = .white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])

        contentView.addSubview(subHeaderLabel)
        NSLayoutConstraint.activate([
            subHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            subHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])

        contentView.addSubview(footerLabel)
        NSLayoutConstraint.activate([
            footerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            footerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            footerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])

        contentView.layer.cornerRadius = 12
    }
}
