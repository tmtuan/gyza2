//
//  LoginViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/17/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    var userLoggedIn = UserLoggedIn()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.white
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        // make round corners
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginRegisterClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Skip", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSkipButtonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Name"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let nameSeparatorView: UIView = {
       let view = UIView()
       view.backgroundColor = UIColor.gray
       view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sampleProfile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = UIColor.white
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleLoginRegisterChanged), for: .valueChanged)
        return sc
    }()
    
    // inputs Container's Height changes depending on Login / Register toggles
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    // MARK: Methods
    
    func handleSkipButtonClick() {
    
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            if let navigationController = topController.childViewControllers[3] as? UINavigationController {
                
                if let accountViewController = navigationController.childViewControllers[0] as? AccountViewController {
                    accountViewController.isSkippedLogin = true
                }
            }
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func handleLoginRegisterChanged() {
        
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        nameTextField.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true : false
        
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true

        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true

    }
    
    func handleLoginRegisterClick() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }

    func handleRegister() {
        print("Register")
    }
    
    /**
     * Method name: <#handleLogin#>
     * Description: handle Login function
     * Parameters: <#parameters#>
     */
    func handleLogin() {
        
        print("Login")
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        // Prepare json http Body
        let json = ["email" : "\(email.lowercased())", "password" : "\(password)"] as [String: Any]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) {
            
            // Prepare
            let loginAPIUrl = URL(string: "https://api.gyza.vn/api/signin")
            
            let request = NSMutableURLRequest(url: loginAPIUrl!)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData

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
                        if let isLoggedIn = rootDictionary["success"] as? NSNumber {
                            self.userLoggedIn.success = isLoggedIn.intValue
                            
                            if let session = rootDictionary["session"] as? NSNumber {
                                self.userLoggedIn.session = session.intValue
                            }
                            
                            if let token = rootDictionary["token"] as? String {
                                self.userLoggedIn.token = token
                            }
                            
                            if let user = rootDictionary["user"] as? [String:Any] {
                                self.userLoggedIn.user = User()
                                
                                if let id = user["id"] as? String {
                                    self.userLoggedIn.user?.id = id
                                }
                                if let isAdmin = user["isAdmin"] as? String {
                                    self.userLoggedIn.user?.isAdmin = Int(isAdmin) == 1 ? true : false
                                }
                                if let isSupplier = user["isSupplier"] as? String {
                                    self.userLoggedIn.user?.isSupplier = Int(isSupplier) == 1 ? true : false
                                }
                                if let displayName = user["displayName"] as? String {
                                    self.userLoggedIn.displayName = displayName
                                }
                                if let avatar = user["avatar"] as? [String: Any] {
                                    if let secure_url = avatar["secure_url"] as? String {
                                        self.userLoggedIn.user?.avatar = secure_url
                                    }
                                }
                                
                            }

                            DispatchQueue.main.sync {
                                self.finishLoggingIn()
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
    
    func finishLoggingIn() {
        
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.set(userLoggedIn.user?.id, forKey: "userId")
        UserDefaults.standard.set(userLoggedIn.token, forKey: "token")
        
        UserDefaults.standard.synchronize()
        
        if let topController = UIApplication.shared.keyWindow?.rootViewController {
            if let navigationController = topController.childViewControllers[3] as? UINavigationController {
                
                if let accountViewController = navigationController.childViewControllers[0] as? AccountViewController {
                    accountViewController.userLoggedIn = self.userLoggedIn
                }
            }
            
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func checkIfUserIsLoggedIn() {
        if userLoggedIn.success == 1 {
            print("User has logged in")
    
        } else {
            print("User has not loged in")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.set("", forKey: "userId")
        UserDefaults.standard.set("", forKey: "token")
        
        observeKeyboardNotification()
        
        let image = UIImage(named: "loginBackgroundImage")
        image?.draw(in: self.view.bounds)
        view.backgroundColor = UIColor(patternImage: image!)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(skipButton)
        
        setupInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
        setupLoginRegisterSegmentedControl()
        setupSkipButton()
        
        handleLoginRegisterChanged()
        
        checkIfUserIsLoggedIn()
        
    }

    fileprivate func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width:self.view.frame.width, height:self.view.frame.height)
        }, completion: nil)
        print("keyboard shown")
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width:self.view.frame.width, height:self.view.frame.height)
        }, completion: nil)
        print("keyboard hide")
    }
    
    func setupInputsContainerView() {
        // Add constraints for inputsContainerView
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputsContainerViewHeightAnchor?.isActive = true
        
        // Add name textfields
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        // Name Separator
        inputsContainerView.addSubview(nameSeparatorView)
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Add email textfields
        inputsContainerView.addSubview(emailTextField)
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeparatorView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        // Email Separator
        inputsContainerView.addSubview(emailSeparatorView)
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Add password textfields
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.topAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
        // Password Separator
        inputsContainerView.addSubview(passwordSeparatorView)
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordSeparatorView.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 22).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupSkipButton() {
        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        skipButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 22).isActive = true
        skipButton.widthAnchor.constraint(equalTo: loginRegisterButton.widthAnchor).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupProfileImageView() {
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -24).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setupLoginRegisterSegmentedControl() {
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        get {
            return .lightContent
        }
    }
}
