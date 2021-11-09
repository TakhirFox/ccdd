//
//  SceneDelegate.swift
//  ccdd
//
//  Created by Zakirov Tahir on 05.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowsScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        window?.windowScene = windowsScene
        window?.rootViewController = UINavigationController(rootViewController: ContactsController())
        window?.makeKeyAndVisible()
    }



}

