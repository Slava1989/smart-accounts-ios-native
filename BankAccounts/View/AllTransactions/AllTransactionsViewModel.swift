//
//  AllTransactionsViewModel.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import Foundation
import Combine

protocol AllTransactionsViewModelInput: AnyObject {
    var subject: CurrentValueSubject<[ViewModelTransaction], Error>{ get set }

    func checkDate(date: Date) -> String
    func filterTransactions()
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

    var subject = CurrentValueSubject<[ViewModelTransaction], Error>([])

    init(coordinator: AllTransactionsCoordinator) {
        self.coordinator = coordinator
        getAllTransactions()
    }

    private func getAllTransactions() {
        NetworkTransactionManager.shared.fetchTransactions { [weak self] transactions, error in
            if error == nil {
                let transactionDictionary = self?.makeTransactionDictionary(transactions: transactions)
                self?.subject.send(transactionDictionary ?? [])
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

    func checkDate(date: Date) -> String {
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        }

        return ""
    }

    func filterTransactions() {

    }
}
