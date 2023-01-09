//
//  AppCoordinator.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func end()
}


final class AppCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let dashboardCoordinator = AllAccountsCoordinator()
        dashboardCoordinator.start()
        childCoordinator = [dashboardCoordinator]
        window?.rootViewController  = dashboardCoordinator.rootViewController
    }

    func end() {}
}
