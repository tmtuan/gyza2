//
//  CustomTabBarController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/12/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let navigationController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        navigationController.title = "Interior"
        navigationController.tabBarItem.image = UIImage(named: "home")
        
        //let collectionController = ProductViewController()
        let productLayout = UICollectionViewFlowLayout()
        //collectionController.view.backgroundColor = UIColor.yellow
        //collectionController.navigationItem.title = "Collection"
        productLayout.minimumInteritemSpacing = 1
        productLayout.minimumLineSpacing = 2
        let secondNavigationController = UINavigationController(rootViewController: ProductViewController(collectionViewLayout: productLayout))
        secondNavigationController.title = "Collection"
        secondNavigationController.tabBarItem.image = UIImage(named: "collection")
        
        let starController = UIViewController()
        starController.view.backgroundColor = UIColor.red
        starController.navigationItem.title = "Favorites"
        let thirdNavigationController = UINavigationController(rootViewController: starController)
        thirdNavigationController.title = "Favorites"
        thirdNavigationController.tabBarItem.image = UIImage(named: "star")
        
        let accountController = AccountViewController()
        accountController.view.backgroundColor = UIColor.white
        accountController.navigationItem.title = "Account"
        let fourthNavigationController = UINavigationController(rootViewController: accountController)
        //fourthNavigationController.setNavigationBarHidden(true, animated: true)
        fourthNavigationController.title = "Account"
        fourthNavigationController.tabBarItem.image = UIImage(named: "user_profile")

        
//        let accountController = LoginViewController()
//        accountController.navigationItem.title = "Account"
//        let fourthNavigationController = UINavigationController(rootViewController: accountController)
//        fourthNavigationController.setNavigationBarHidden(true, animated: true)
//        fourthNavigationController.title = "Account"
//        fourthNavigationController.tabBarItem.image = UIImage(named: "user_profile")

        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]

        // make the tab menu translucent or not - up to you
        // tabBar.isTranslucent = false
    }
}
