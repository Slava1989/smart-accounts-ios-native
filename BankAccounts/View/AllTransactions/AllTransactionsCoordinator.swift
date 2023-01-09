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

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let allTransactionsViewModel = AllTransactionsViewModel(coordinator: self)
        let allTransactionsViewController = AllTransactionsViewController(viewModel: allTransactionsViewModel)

        allTransactionsViewController.navigationItem.title = "Multibanking"

        rootViewController.pushViewController(allTransactionsViewController, animated: true)
    }

    func end() {
        
    }


}
