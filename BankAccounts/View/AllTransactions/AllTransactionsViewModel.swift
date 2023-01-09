//
//  AllTransactionsViewModel.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 06.01.2023.
//

import Foundation
import Combine

protocol AllTransactionsViewModelInput: AnyObject {

    func getAllTransactions()
    func filterTransactions()
}

final class AllTransactionsViewModel: AllTransactionsViewModelInput {
    private var coordinator: AllTransactionsCoordinator
    private var allTransactions: [Transaction]?

    var subject = CurrentValueSubject<[Transaction], Error>([])

    init(coordinator: AllTransactionsCoordinator) {
        self.coordinator = coordinator
    }

    func getAllTransactions() {

    }

    func filterTransactions() {

    }


}
