//
//  InformationView.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 09.01.2023.
//

import UIKit

final class InformationView: UIView {
    private lazy var informationIcon: UIImageView = {
        let informationIcon = UIImageView()
        informationIcon.image = UIImage(systemName: "info.circle.fill")
        informationIcon.tintColor = UIColor.gray
        informationIcon.translatesAutoresizingMaskIntoConstraints = false
        return informationIcon
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 15)
        label.text = "Please keep in mind that the data displayed will refresh every 60 minutes from the first time is diplayed on this dashboard!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(informationIcon)
        NSLayoutConstraint.activate([
            informationIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            informationIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            informationIcon.widthAnchor.constraint(equalToConstant: 25),
            informationIcon.heightAnchor.constraint(equalToConstant: 25)
        ])

        self.addSubview(messageLabel)
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: informationIcon.leadingAnchor, constant: -40)
        ])
    }
}
