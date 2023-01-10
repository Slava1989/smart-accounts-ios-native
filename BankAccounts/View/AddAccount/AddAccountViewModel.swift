//
//  AddAccountViewModel.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 09.01.2023.
//

import Foundation
import Combine

protocol AddAccountViewModelInput: AnyObject {
    var subject: CurrentValueSubject<[Bank], Error>{ get set }

    func fetchBanks()
}

final class AddAccountViewModel: AddAccountViewModelInput {
    private var coordinator: AddAccountCoordinator
    private var banks: [Bank]?

    var subject = CurrentValueSubject<[Bank], Error>([])

    init(coordinator: AddAccountCoordinator) {
        self.coordinator = coordinator
    }

    func fetchBanks() {
        NetworkBankManager.shared.fetchBanks { [weak self] bank, error in
            self?.subject.send(bank)
        }
    }
}
