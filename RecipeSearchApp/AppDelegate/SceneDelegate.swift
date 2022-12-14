//
//  SceneDelegate.swift
//  RecipeSearchApp
//
//  Created by Passant Abdelatif on 02/11/2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setRootViewController(scene: scene)
       
    }


}

@available(iOS 13.0, *)
extension SceneDelegate {
    func setRootViewController(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigationController = UINavigationController()
        navigationController.viewControllers = [RecipeSearchViewController()]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
