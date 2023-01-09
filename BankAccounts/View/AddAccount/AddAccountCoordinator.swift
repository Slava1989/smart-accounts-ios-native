//
//  AddAccountCoordinator.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 09.01.2023.
//

import UIKit

final class AddAccountCoordinator: Coordinator {
    var rootViewController: UINavigationController
    var childCoordinator = [Coordinator]()

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func start() {
        let addAccountViewModel = AddAccountViewModel(coordinator: self)
        let addAccountViewController = AddAccountViewController(viewModel: addAccountViewModel)

        addAccountViewController.navigationItem.title = "Cont all"
        rootViewController.pushViewController(addAccountViewController, animated: true)
    }

    func end() {
        rootViewController.popViewController(animated: true)
    }
}
