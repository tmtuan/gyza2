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
        
        let collectionController = UIViewController()
        collectionController.navigationItem.title = "Collection"
        let secondNavigationController = UINavigationController(rootViewController: collectionController)
        secondNavigationController.title = "Collection"
        secondNavigationController.tabBarItem.image = UIImage(named: "collection")
        
        let starController = UIViewController()
        starController.navigationItem.title = "Favorites"
        let thirdNavigationController = UINavigationController(rootViewController: starController)
        thirdNavigationController.title = "Favorites"
        thirdNavigationController.tabBarItem.image = UIImage(named: "star")
        
        let accountController = UIViewController()
        accountController.navigationItem.title = "Account"
        let fourthNavigationController = UINavigationController(rootViewController: accountController)
        fourthNavigationController.title = "Account"
        fourthNavigationController.tabBarItem.image = UIImage(named: "user_profile")

        

        
        
        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]
    }
}
