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
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "accountBackground")!)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
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
        profileImageView.setupImage(url: userLoggedIn?.user?.avatar)
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
        request.addValue(UserDefaults.standard.string(forKey: "token")!, forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print(jsonResponse!)
                
                // Check if token is still valid or not
                if let rootDictionary = jsonResponse as? [String: Any] {
                    if let code = rootDictionary["code"] as? Int {
                        if code == 30 {
                            print("Token is invalid")
                        }
                    }
                }
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
    
        self.navigationController?.navigationBar.isTranslucent = true
        
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
        profileImageView.setupImage(url: userLoggedIn?.user?.avatar)

    }
    
    func finishRefreshingToken() {
        UserDefaults.standard.set(userLoggedIn?.token, forKey: "token")
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
        // If logged in
        else {
            let userId: String! = UserDefaults.standard.string(forKey: "userId")
            if( userId != "" ) {
                // Check if token is still valid
                // Prepare Request
                let requestURL = "https://api.gyza/vn/users/\(userId!)"
                let getUserByIdAPIUrl = URL(string: requestURL)
                let request = NSMutableURLRequest(url: getUserByIdAPIUrl!)
                request.httpMethod = "GET"
            
                // Send Request
                URLSession.shared.dataTask(with: request as URLRequest) {
                    data, response, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        print(jsonResponse!)
                        
                        // Check if token is still valid or not
                        if let rootDictionary = jsonResponse as? [String: Any] {
                            if let code = rootDictionary["code"] as? Int {
                                if code == 30 {
                                    // refresh token
                                    let refreshTokenAPIUrl = URL(string: "https://api.gyza.vn/refreshtoken")
                                    let request = NSMutableURLRequest(url: refreshTokenAPIUrl!)
                                    request.httpMethod = "GET"
                                    request.addValue(UserDefaults.standard.string(forKey: "token")!, forHTTPHeaderField: "token")
                                    
                                    // get user info
                                    URLSession.shared.dataTask(with: request as URLRequest) {
                                        data, response, error in
                                        if error != nil {
                                            print(error!)
                                            return
                                        }
                                        
                                        do {
                                            let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                            
                                            print(jsonResponse!)
                                            
                                            if let rootDictionary = jsonResponse as? [String: Any] {
                                                self.userLoggedIn = UserLoggedIn()
                                                if let isLoggedIn = rootDictionary["success"] as? NSNumber {
                                                    self.userLoggedIn?.success = isLoggedIn.intValue
                                                    
                                                    if let session = rootDictionary["session"] as? NSNumber {
                                                        self.userLoggedIn?.session = session.intValue
                                                    }
                                                    
                                                    if let token = rootDictionary["token"] as? String {
                                                        self.userLoggedIn?.token = token
                                                    }
                                                    
                                                    if let user = rootDictionary["user"] as? [String:Any] {
                                                        self.userLoggedIn?.user = User()
                                                        
                                                        if let id = user["id"] as? String {
                                                            self.userLoggedIn?.user?.id = id
                                                        }
                                                        if let isAdmin = user["isAdmin"] as? String {
                                                            self.userLoggedIn?.user?.isAdmin = Int(isAdmin) == 1 ? true : false
                                                        }
                                                        if let isSupplier = user["isSupplier"] as? String {
                                                            self.userLoggedIn?.user?.isSupplier = Int(isSupplier) == 1 ? true : false
                                                        }
                                                        if let displayName = user["displayName"] as? String {
                                                            self.userLoggedIn?.displayName = displayName
                                                        }
                                                        if let avatar = user["avatar"] as? [String: Any] {
                                                            if let secure_url = avatar["secure_url"] as? String {
                                                                self.userLoggedIn?.user?.avatar = secure_url
                                                            }
                                                        }
                                                    }
                                                    
                                                    DispatchQueue.main.sync {
                                                        self.finishRefreshingToken()
                                                    }
                                                    
                                                } else if let error = rootDictionary["error"] as? [String: Any] {
                                                    if let error_en = error["en"] as? String {
                                                        print(error_en)
                                                    }
                                                }
                                            }
                                            
                                        } catch let error as NSError {
                                            print(error)
                                        }
                                        }.resume()
                                }
                            }
                        }
                        DispatchQueue.main.sync {
                            self.finishRefreshingToken()
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }.resume()
            }
        }
    }

}
 
