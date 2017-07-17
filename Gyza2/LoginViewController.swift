//
//  LoginViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/17/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
    
        setupInputsContainerView()
        setupLoginRegisterButton()
    }

    func setupInputsContainerView() {
        // Add constraints for inputsContainerView
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true

    }
    
    func setupLoginRegisterButton() {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        get {
            return .lightContent
        }
    }
}
