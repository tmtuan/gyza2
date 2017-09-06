//
//  LoginCell.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/5/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    // MARK: Properties
    let logoImageView: UIImageView = {
        let image = UIImage(named: "sampleProfile")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter your email..."
        let borderColor = UIColor.lightGray
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password..."
        let borderColor = UIColor.lightGray
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let skipLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Skip log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSkipButtonClick), for: UIControlEvents.touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Events Handlers
    func handleSkipButtonClick() {
        print("123")
    }
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(skipLoginButton)
        
        // LogoImageView's Constraints
        logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -200).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        // EmailTextField's Constraints
        emailTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // PasswordTextField's Constraints
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // LoginButton's Constraints
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // SkipLoginButton's Constraints
        skipLoginButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16).isActive = true
        skipLoginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        skipLoginButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32).isActive = true
        skipLoginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
