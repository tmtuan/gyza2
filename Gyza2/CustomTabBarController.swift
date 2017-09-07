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
        
        if isLoggedIn() {
            // assum user is logged in
        } else {
            perform(#selector(showIntroViewController), with: nil, afterDelay: 0.01)
        }
        
        let layout = UICollectionViewFlowLayout()
        let navigationController = UINavigationController(rootViewController: HomeController(collectionViewLayout: layout))
        navigationController.title = "Interior"
        navigationController.tabBarItem.image = UIImage(named: "home")
        
        let productLayout = UICollectionViewFlowLayout()
        productLayout.minimumInteritemSpacing = 1
        productLayout.minimumLineSpacing = 2
        let secondNavigationController = UINavigationController(rootViewController: ProductViewController(collectionViewLayout: productLayout))
        secondNavigationController.title = "Product"
        secondNavigationController.tabBarItem.image = UIImage(named: "collection")
        
        let searchLayout = PinterestLayout()
        let thirdNavigationController = UINavigationController(rootViewController: SearchController(collectionViewLayout: searchLayout))
        thirdNavigationController.title = "Search"
        thirdNavigationController.tabBarItem.image = UIImage(named: "search")
        
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
    
    func isLoggedIn() -> Bool {
        return false
    }
    func showIntroViewController() {
        let introViewController = IntroViewController()
        present(introViewController, animated: true, completion: {
            // Do something here
        })
    }
}
