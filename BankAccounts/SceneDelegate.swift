//
//  SceneDelegate.swift
//  BankAccounts
//
//  Created by Veaceslav Chirita on 02.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let applicationCoordinator = AppCoordinator(window: window)
            applicationCoordinator.start()

            self.appCoordinator = applicationCoordinator
            window.makeKeyAndVisible()
        }
    }
}

