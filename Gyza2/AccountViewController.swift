//
//  UserProfileViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 8/19/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.blue
        
        let x = isLoggedIn()
        
        if !x {
            
            let loginViewController = LoginViewController()
            present(loginViewController, animated: true, completion: nil)
        }
    }
    
    func isLoggedIn() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "isLoggedIn")

    }
}
 
