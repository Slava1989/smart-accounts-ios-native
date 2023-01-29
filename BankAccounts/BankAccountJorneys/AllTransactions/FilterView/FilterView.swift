//
//  FilterView.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 13.01.2023.
//

import UIKit

protocol FilterViewDelegate: AnyObject {
    func didTapCloseButton()
    func didTapBankSelect()
    func didSelectBankName()

    func didTapApply(bankName: String, accountNumber: String, fromDatae: String, toDate: String)
}

final class FilterView: UIView, UITableViewDataSource, UITableViewDelegate {
    private var listOfBanks = [
        "BCR",
        "BRD SocGen",
        "Banca Transilvania",
        "Raiffeisen Bank",
        "CEC Bank",
        "UniCredit Țiriac",
        "Alpha Bank",
        "ING Bank",
        "Credit Europe",
        "Citibank România",
        "Banca Românească",
        "OTP Bank România",
        "GarantiBank România",
        "Intesa Sanpaolo România",
        "Marfin Bank România",
        "MKB Romexterra",
        "Eximbank",
        "Anglo Romanian Bank",
        "ATE Bank România",
        "Procredit Bank România",
        "Libra Bank",
        "Emporiki Bank România",
        "Creditcoop",
        "Banca Comercială Feroviară"
    ]


    weak var delegate: FilterViewDelegate?
    var pickerToolbar: UIToolbar?

    @IBOutlet private weak var bankListTableView: UITableView!
    @IBOutlet private weak var bankListView: UIView!

    @IBOutlet private weak var accountNumberLabel: UILabel!
    @IBOutlet private weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var mainFilterView: UIView!
    @IBOutlet private weak var fromTextField: UITextField!
    @IBOutlet private weak var toTextField: UITextField!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var applyButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var bankNameLabel: UILabel!
    @IBOutlet private weak var bankSelectStackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("FilterView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        bankListView.isHidden = true

        bankListTableView.delegate = self
        bankListTableView.dataSource = self

        setupUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnView))
        self.isUserInteractionEnabled = true

        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)

        let bankViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnBankListStackView))
        bankSelectStackView.addGestureRecognizer(bankViewTapGesture)
        bankSelectStackView.isUserInteractionEnabled = true
    }

    @objc func didTapOnView() {
        fromTextField.resignFirstResponder()
        toTextField.resignFirstResponder()
    }

    @objc private func didTapOnBankListStackView() {
        delegate?.didTapBankSelect()
        mainFilterView.isHidden = true
        bankListView.isHidden = false
        mainViewHeightConstraint.constant = 0
        bankListTableView.reloadData()

        self.layoutIfNeeded()
    }

    @objc func handleFromDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        fromTextField.text = dateFormatter.string(from: sender.date)
    }

    @objc func handleToDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        toTextField.text = dateFormatter.string(from: sender.date)
    }

    private func setupUI() {
        cancelButton.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        applyButton.titleLabel?.font = UIFont(name: "Helvetica", size: 17)

        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.borderWidth = 1

        applyButton.layer.cornerRadius = 10

        let fromDatePicker = UIDatePicker()
        fromDatePicker.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 150)
        fromDatePicker.datePickerMode = .date
        fromDatePicker.addTarget(self, action: #selector(handleFromDatePicker(sender:)), for: .valueChanged)

        let toDatePicker = UIDatePicker()
        toDatePicker.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 150)
        toDatePicker.datePickerMode = .date
        toDatePicker.addTarget(self, action: #selector(handleToDatePicker(sender:)), for: .valueChanged)
        toDatePicker.maximumDate = Date()


        fromTextField.inputView = fromDatePicker
        toTextField.inputView = toDatePicker

        fromDatePicker.preferredDatePickerStyle = .wheels
        toDatePicker.preferredDatePickerStyle = .wheels
    }

    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        print(#function)
    }

    @IBAction func applyButtonDidTap(_ sender: UIButton) {
        guard let bankName = bankNameLabel.text,
              let accountNumber = accountNumberLabel.text,
              let fromTextField = fromTextField.text,
              !fromTextField.isEmpty,
              fromTextField != "From",
              let toTextField =  toTextField.text,
              !toTextField.isEmpty,
              toTextField != "To" else {
            return
        }

        delegate?.didTapApply(bankName: bankName,
                              accountNumber: accountNumber,
                              fromDatae: fromTextField,
                              toDate: toTextField)
    }

    @IBAction func didTapCloseButton(_ sender: UIButton) {
        delegate?.didTapCloseButton()
    }

    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bankNameLabel.text = listOfBanks[indexPath.row]
        delegate?.didSelectBankName()

        mainFilterView.isHidden = false
        bankListView.isHidden = true
        mainViewHeightConstraint.constant = 420

        self.layoutIfNeeded()
    }

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfBanks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = listOfBanks[indexPath.row]

        return cell
    }
}
