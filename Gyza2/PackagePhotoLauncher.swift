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
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut,
                           animations: {
                            view.frame = keyWindow.frame
            
            }, completion: {(completedAnimation) in
                // Do something here later
            })
        }
     
    }
}
