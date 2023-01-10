//
//  SetupView.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

protocol SetupViewDelegate: AnyObject {
    func didTapClose()
    func showAccountTitleField()
    func showCurrencyFormField()
}

final class SetupView: UIView, TableOptionsDelegate {
    weak var delegate: SetupViewDelegate?

    private var isPeriodSet = false
    private var isAccountSet = false
    private var isCurrencySet = false
    private var buttonHeightConstraint: NSLayoutConstraint?

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.contentMode = .scaleToFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var bankTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var selectTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.text = "Selecteaza perioada"
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var periodFormField: AddAccountFormField = {
        let formField = AddAccountFormField(frame: .zero, isExpandable: true, title: "Selecteaza perioada")
        formField.setupDefault(value: "90 zile")
        formField.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPeriodField))
        formField.addGestureRecognizer(tapGesture)
        formField.isUserInteractionEnabled = true
        return formField
    }()

    private lazy var accountTitleField: AddAccountFormField = {
        let formField = AddAccountFormField(frame: .zero, isExpandable: false, title: "Selecteaza contul")
        formField.isHidden = true
        formField.translatesAutoresizingMaskIntoConstraints = false
        return formField
    }()

    private lazy var currencyFormField: AddAccountFormField = {
        let formField = AddAccountFormField(frame: .zero, isExpandable: true, title: "Selecteaza moneda contului")
        formField.setupDefault(value: "Selecteaza")
        formField.translatesAutoresizingMaskIntoConstraints = false
        formField.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCurrencyFormField))
        formField.addGestureRecognizer(tapGesture)
        formField.isUserInteractionEnabled = true
        return formField
    }()

    private lazy var optionsView: TableOptions = {
        let view = TableOptions(frame: .zero, options: ["30 zile", "60 zile", "90 zile"])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.isHidden = true
        return view
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "red")
        button.setTitle("Trimite cererea", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sendRequest), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setBankTitle(bankTitle: String) {
        bankTitleLabel.text = bankTitle

        if let buttonHeightConstraint = buttonHeightConstraint {
            buttonHeightConstraint.constant = 48
        }
    }

    private func setupUI() {
        self.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40)
        ])

        self.addSubview(selectTitleLabel)
        NSLayoutConstraint.activate([
            selectTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            selectTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        ])

        self.addSubview(bankTitleLabel)
        NSLayoutConstraint.activate([
            bankTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            bankTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        self.addSubview(periodFormField)
        NSLayoutConstraint.activate([
            periodFormField.topAnchor.constraint(equalTo: bankTitleLabel.topAnchor, constant: 40),
            periodFormField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            periodFormField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])

        self.addSubview(accountTitleField)
        NSLayoutConstraint.activate([
            accountTitleField.topAnchor.constraint(equalTo: periodFormField.bottomAnchor, constant: 20),
            accountTitleField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            accountTitleField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])

        self.addSubview(currencyFormField)
        NSLayoutConstraint.activate([
            currencyFormField.topAnchor.constraint(equalTo: accountTitleField.bottomAnchor, constant: 20),
            currencyFormField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            currencyFormField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])

        self.addSubview(sendButton)
        buttonHeightConstraint = sendButton.heightAnchor.constraint(equalToConstant: 0)
        buttonHeightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalToConstant: 250),
            sendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])

        self.addSubview(optionsView)
        NSLayoutConstraint.activate([
            optionsView.topAnchor.constraint(equalTo: selectTitleLabel.topAnchor, constant: 25),
            optionsView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            optionsView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            optionsView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func didSelect(option: String) {
        hidePeriodTable()
        periodFormField.setupValue(option: option)
    }

    @objc private func closeDidTap() {
        delegate?.didTapClose()
        buttonHeightConstraint?.constant = 0
    }

    @objc private func sendRequest() {
        if !isAccountSet {
            isAccountSet = true
            accountTitleField.isHidden = false
            delegate?.showAccountTitleField()

            return
        }

        if !isCurrencySet {
            isCurrencySet = true
            currencyFormField.isHidden = false
            delegate?.showCurrencyFormField()
        }
    }

    @objc private func didTapPeriodField() {
        showOrHidePeriodTable(isShown: false)
    }

    @objc private func didTapCurrencyFormField() {

    }

    private func hidePeriodTable() {
        showOrHidePeriodTable(isShown: true)
    }

    private func showOrHidePeriodTable(isShown: Bool) {
        bankTitleLabel.isHidden = !isShown
        periodFormField.isHidden = !isShown
        selectTitleLabel.isHidden = isShown

        optionsView.isHidden = isShown
    }
}
