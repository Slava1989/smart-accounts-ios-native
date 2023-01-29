//
//  AllTransactionsCoordinator.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 03.01.2023.
//

import UIKit

final class AllTransactionsCoordinator: Coordinator {
    private struct Constants {
        static var title = R.string.localizable.allTransactionsScreenTitle()
    }

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

        allTransactionsViewController.navigationItem.title = Constants.title

        rootViewController.pushViewController(allTransactionsViewController, animated: true)
    }

    func end() {
        
    }


}
