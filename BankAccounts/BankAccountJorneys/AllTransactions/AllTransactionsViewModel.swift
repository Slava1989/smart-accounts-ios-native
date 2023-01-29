//
//  AllTransactionsViewModel.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import Foundation
import Combine

protocol AllTransactionsViewModelInput: AnyObject {
    var transitionSubject: CurrentValueSubject<[ViewModelTransaction], Error>{ get set }

    func didChangeSearchText(searchText: String)
    func checkDate(date: Date) -> String
    func filterTransactions(by bankAccount: BankAccount?)
    func filterTransactions(bankName: String, accountNumber: String, fromDate: String, toDate: String)
}

class ViewModelTransaction {
    let date: String
    let transactions: [Transaction]

    init(date: String, transactions: [Transaction]) {
        self.date = date
        self.transactions = transactions
    }
}

final class AllTransactionsViewModel: AllTransactionsViewModelInput {
    private var coordinator: AllTransactionsCoordinator
    private var allTransactions: [Transaction]?
    private var modeledTransactions: [ViewModelTransaction] = []

    var transitionSubject = CurrentValueSubject<[ViewModelTransaction], Error>([])

    init(coordinator: AllTransactionsCoordinator) {
        self.coordinator = coordinator
        getAllTransactions()
    }

    private func getAllTransactions() {
        NetworkTransactionManager.shared.fetchTransactions { [weak self] transactions, error in
            guard let self = self else { return }

            if error == nil {
                self.modeledTransactions = self.makeTransactionDictionary(transactions: transactions)
                self.transitionSubject.send(self.modeledTransactions)
            }
        }
    }

    private func makeTransactionDictionary(transactions: [Transaction]) -> [ViewModelTransaction] {
        var transactionDictionary: [String:[Transaction]] = [:]

        transactions.forEach { transaction in
            if transactionDictionary[transaction.date] == nil {
                transactionDictionary[transaction.date] = [transaction]
            } else {
                transactionDictionary[transaction.date]?.append(transaction)
            }
        }

        let modeledTransactions = transactionDictionary.map { (key, value) -> ViewModelTransaction in
            return ViewModelTransaction(date: key, transactions: value)
        }.sorted { $0.date > $1.date }

        return modeledTransactions
    }

    func filterTransactions(bankName: String, accountNumber: String, fromDate: String, toDate: String) {
        let from = fromDate.toDate() ?? Date()
        let to = toDate.toDate() ?? Date()

        let filteredTransactions = modeledTransactions.filter { transactionsArray in
            transactionsArray.transactions.contains { transaction in
                let transactionDate = transaction.date.toDate() ?? Date()

                return bankName.lowercased().contains(transaction.bankName.lowercased()) &&
                transactionDate.isBetween(from, and: to)
            }
        }

        transitionSubject.send(filteredTransactions)
    }

    func checkDate(date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }

        return ""
    }

    func didChangeSearchText(searchText: String) {
        guard !searchText.isEmpty else {
            transitionSubject.send(modeledTransactions)
            return
        }

        let filteredTransactions = modeledTransactions.filter { transactionsArray in
            transactionsArray.transactions.contains { transaction in
                let searchTextLowerCased = searchText.lowercased()
                return transaction.bankName.lowercased().contains(searchTextLowerCased) ||
                transaction.descritpion.lowercased().contains(searchTextLowerCased) ||
                transaction.category.rawValue.lowercased().contains(searchTextLowerCased)
            }
        }

        transitionSubject.send(filteredTransactions)
    }

    func filterTransactions(by bankAccount: BankAccount?) {
        guard let bankAccount = bankAccount else {
            transitionSubject.send(modeledTransactions)
            return
        }

        let filteredTransactions = modeledTransactions.filter { transactionsArray in
            transactionsArray.transactions.contains { transaction in
                return transaction.bankName.lowercased().contains(bankAccount.bankName.lowercased())
            }
        }

        transitionSubject.send(filteredTransactions)
    }
}
