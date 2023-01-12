//
//  AllTransactionsViewController.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import UIKit
import Combine

final class AllTransactionsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {

    private var viewModel: AllTransactionsViewModelInput
    private var allTransactions: [ViewModelTransaction] = []
    private var bankAccounts: [BankAccount] = []
    private var cancellable = Set<AnyCancellable>()

    private lazy var bankAccountsContainerView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        collectionView.register(AllCell.self, forCellWithReuseIdentifier: "allCell")

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var transactionListLabel: UILabel = {
        let label = UILabel()
        label.text = "Lista tranzactii"
        label.font = UIFont(name: "Helvetica-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Cauta in tranzactii"
        textField.borderStyle = .roundedRect
        textField.leftViewMode = UITextField.ViewMode.always
        textField.setLeftView(image: UIImage(systemName: "magnifyingglass")!)
        textField.tintColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
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
        collectionView.reloadData()
        getAllTransactions()
    }

    private func setupUI() {
        view.addSubview(bankAccountsContainerView)
        NSLayoutConstraint.activate([
            bankAccountsContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            bankAccountsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bankAccountsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bankAccountsContainerView.heightAnchor.constraint(equalToConstant: 300)
        ])

        bankAccountsContainerView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: bankAccountsContainerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: bankAccountsContainerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: bankAccountsContainerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bankAccountsContainerView.bottomAnchor)
        ])

        view.addSubview(transactionListLabel)
        NSLayoutConstraint.activate([
            transactionListLabel.topAnchor.constraint(equalTo: bankAccountsContainerView.bottomAnchor, constant: 25),
            transactionListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])

        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: transactionListLabel.bottomAnchor, constant: 30),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 45)
        ])

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
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

    //MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        viewModel.getTransactions(cardId: indexPath.row)
    }

    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bankAccounts.count + 1

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allCell", for: indexPath) as? AllCell else { return UICollectionViewCell() }

            return cell
        }

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else { return UICollectionViewCell() }

        let bankAccount = bankAccounts[indexPath.row - 1]
        cell.configureCell(bankAccount: bankAccount)
        return cell
    }

    //MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.row == 0 {
            return CGSize(width: 270, height: 250)
        }

        return CGSize(width: 350, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {


        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
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

    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    //        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    //    }

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
}
