//
//  AllAccountsCoordinator.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import UIKit

final class AllAccountsCoordinator: Coordinator {
    struct Constants {
        static var allAccountsScreenTitle = R.string.localizable.allAccountsScreenTitle()
    }

    var rootViewController: UINavigationController
    var childCoordinator = [Coordinator]()

    init() {
        self.rootViewController = UINavigationController()
    }

    func goToAllTransactions(bankAccounts: [BankAccount]) {
        let allTransactionsCoordinator = AllTransactionsCoordinator(rootViewController: rootViewController, bankAccounts: bankAccounts)
        allTransactionsCoordinator.start()
    }

    func goToAddAccount() {
        let addAccountCoordinator = AddAccountCoordinator(rootViewController: rootViewController)
        addAccountCoordinator.start()
    }

    func start() {
        let allAccountsViewModel = AllAccountsViewModel(coordinator: self)
        let allAccountsViewController = AllAccountsViewController(viewModel: allAccountsViewModel)

        allAccountsViewController.navigationItem.title = Constants.allAccountsScreenTitle
        rootViewController.setViewControllers([allAccountsViewController], animated: true)
    }

    func end() {

    }
 }
