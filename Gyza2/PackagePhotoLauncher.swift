//
//  PackagePhotoLauncher.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/15/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class PackagePhotoLauncher: NSObject {
    
    func showPhoto() {
        print("Showing photo")
        
        if let keyWindow = UIApplication.shared.keyWindow {
     
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.red
            
            keyWindow.addSubview(view)
        }
     
    }
}
