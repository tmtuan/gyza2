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
    
    var isSkippedLogin = false
    
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
    
    let logoutButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.white
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        button.addTarget(self, action: #selector(handleLogout), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    // MARK: Methods
    
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
    
    func setupLogoutButton() {
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func handleLogout() {
        print("Logout 123")
        
        //Prepare
        let logoutAPIUrl = URL(string: "https://api.gyza.vn/api/signout")
        let request = NSMutableURLRequest(url: logoutAPIUrl!)
        request.httpMethod = "GET"
        request.addValue((userLoggedIn?.token)!, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print(jsonResponse!)
                
                DispatchQueue.main.sync {
                    self.finishLoggingOut()
                }
            } catch let error as NSError {
                print(error)
            }
        }.resume()
        
    }
    
    func finishLoggingOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        checkLogin()
    }
    
    func isLoggedIn() -> Bool {
        
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
        
    }
    
    // MARK: Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(profileBackgroundView)
        view.addSubview(profileImageView)
        view.addSubview(logoutButton)
        
        setupProfileBackgroundView()
        setupProfileImageView()
        setupLogoutButton()
        
        checkLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        checkLogin()
        print(userLoggedIn?.displayName ?? "Not logged in")
    }
    
    func checkLogin() {
        
        if isSkippedLogin {
            isSkippedLogin = false
            self.tabBarController?.selectedIndex = 0
        
            return
        }
        
        if !isLoggedIn() {
            
            let loginViewController = LoginViewController()
            dismiss(animated: true, completion: nil)
            present(loginViewController, animated: true, completion: nil)
        }
        
    }

    
   
    
   }
 
