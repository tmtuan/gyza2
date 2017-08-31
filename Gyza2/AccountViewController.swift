//
//  UserProfileViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 8/19/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // MARK: Properties
    var userLoggedIn: UserLoggedIn?
    
    let profileBackgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sampleProfile")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        
        imageView.layer.borderWidth = 4
        imageView.layer.borderColor  = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    func setupProfileBackgroundView() {
        profileBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        profileBackgroundView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        profileBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(profileBackgroundView)
        view.addSubview(profileImageView)
        
        setupProfileBackgroundView()
        setupProfileImageView()

        checkLogin()
    }
    
    func isLoggedIn() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "isLoggedIn")

    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        checkLogin()
        print(userLoggedIn?.displayName ?? "Not logged in")
    }
    
    func checkLogin() {
        
        if !isLoggedIn() {
            
            let loginViewController = LoginViewController()
            present(loginViewController, animated: true, completion: nil)
        }

    }
}
 
