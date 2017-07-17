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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        
        view.addSubview(inputsContainerView)
    
        setupInputsContainerView()
    }

    func setupInputsContainerView() {
        // Add constraints for inputsContainerView
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle  {
        get {
            return .lightContent
        }
    }
}
