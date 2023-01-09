//
//  AddAccountViewModel.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 09.01.2023.
//

import Foundation

protocol AddAccountViewModelInput: AnyObject {

}

final class AddAccountViewModel: AddAccountViewModelInput {
    private var coordinator: AddAccountCoordinator
    private var allTransactions: [Transaction]?

//    var subject = CurrentValueSubject<[Transaction], Error>([])

    init(coordinator: AddAccountCoordinator) {
        self.coordinator = coordinator
    }
}
