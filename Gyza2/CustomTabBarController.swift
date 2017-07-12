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
        
        viewControllers = [navigationController]
    }
}
