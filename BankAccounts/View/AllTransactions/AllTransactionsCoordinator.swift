//
//  AllTransactionsCoordinator.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class AllTransactionsCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childCoordinator = [Coordinator]()
    var bankAccounts: [BankAccount]

    init(rootViewController: UINavigationController, bankAccounts: [BankAccount]) {
        self.rootViewController = rootViewController
        self.bankAccounts = bankAccounts
    }

    func start() {
        let allTransactionsViewModel = AllTransactionsViewModel(coordinator: self)
        let allTransactionsViewController = AllTransactionsViewController(viewModel: allTransactionsViewModel,
                                                                          bankAccounts: bankAccounts)

        allTransactionsViewController.navigationItem.title = "Multibanking"

        rootViewController.pushViewController(allTransactionsViewController, animated: true)
    }

    func end() {
        
    }


}
