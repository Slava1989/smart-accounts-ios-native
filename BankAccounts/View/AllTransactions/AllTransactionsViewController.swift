//
//  AllTransactionsViewController.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import UIKit
import Combine

final class AllTransactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, BankAccountViewDelegate, SearchTextFieldDelegate {

    private var viewModel: AllTransactionsViewModelInput
    private var allTransactions: [ViewModelTransaction] = []
    private var bankAccounts: [BankAccount] = []
    private var cancellable = Set<AnyCancellable>()

    private var tableViewLayoutConstraintHeight: NSLayoutConstraint?
    private var tableViewTopLayoutConstraint: NSLayoutConstraint?

    private lazy var bankAccountsContainerView: BankAccountView = {
        let uiView = BankAccountView()
        uiView.delegate = self
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.delegate = self
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.tintColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var transactionListLabel: UILabel = {
        let label = UILabel()
        label.text = "Lista tranzactii"
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "transactionsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(viewModel: AllTransactionsViewModelInput, bankAccounts: [BankAccount]) {
        self.viewModel = viewModel
        self.bankAccounts = bankAccounts

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupUI()
        bankAccountsContainerView.setupBankAccount(bankAccounts: bankAccounts)
        getAllTransactions()
    }

    private func setupUI() {
        view.addSubview(bankAccountsContainerView)
        NSLayoutConstraint.activate([
            bankAccountsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bankAccountsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bankAccountsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bankAccountsContainerView.heightAnchor.constraint(equalToConstant: 290)
        ])

        view.addSubview(transactionListLabel)
        NSLayoutConstraint.activate([
            transactionListLabel.topAnchor.constraint(equalTo: bankAccountsContainerView.bottomAnchor, constant: 10),
            transactionListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])

        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: transactionListLabel.bottomAnchor, constant: 10),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 37)
        ])

        view.addSubview(tableView)
        tableViewTopLayoutConstraint = tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: (view.frame.height / 3) + view.frame.height / 8)
        tableViewTopLayoutConstraint?.isActive = true
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }

    private func getAllTransactions() {
        viewModel.subject.sink { complete in

        } receiveValue: { [weak self] transactions in
            self?.allTransactions = transactions
            self?.tableView.reloadData()
        }.store(in: &cancellable)
    }

    func didChaneText(text: String) {
        viewModel.didChangeSearchText(searchText: text)
    }

    func didSelect(bankAccount: BankAccount?) {
        viewModel.filterTransactions(by: bankAccount)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return allTransactions.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = .white

        let label = UILabel(frame: CGRect(x: 10, y: 7, width: view.frame.size.width, height: 25))
        let dateString = allTransactions[section].date
        let checkedDate = viewModel.checkDate(date: dateString.toDate() ?? Date())

        if checkedDate == "" {
            label.text = dateString
        } else {
            label.text = checkedDate
        }
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .black
        returnedView.addSubview(label)


        return returnedView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 0))
        returnedView.backgroundColor = .white
        return returnedView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateString = allTransactions[section].date
        let checkedDate = viewModel.checkDate(date: dateString.toDate() ?? Date())

        if checkedDate == "" {
            return dateString
        } else {
            return checkedDate
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTransactions[section].transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionsCell", for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }

        let transactions = allTransactions[indexPath.section].transactions
        cell.config(transaction: transactions[indexPath.row])

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            tableViewTopLayoutConstraint?.constant = (view.frame.height / 3) + view.frame.height / 8

            UIView.animate(withDuration: 0.5, delay: 0) {
                self.view.layoutIfNeeded()
            }

        } else if scrollView.contentOffset.y > 0 {
            tableViewTopLayoutConstraint?.constant = 0

            UIView.animate(withDuration: 0.5, delay: 0) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
