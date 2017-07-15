//
//  PackagePhotoLauncher.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/15/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit
class PhotoPlayerView: UIView {
    
    var photoImageView: CustomImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        
        photoImageView = CustomImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        photoImageView?.backgroundColor = UIColor.blue
        photoImageView?.contentMode = .scaleAspectFit
        photoImageView?.clipsToBounds = true
        self.addSubview(photoImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PackagePhotoLauncher: NSObject {
    
    func showPhoto(package: Package) {
        
        
        
        if let keyWindow = UIApplication.shared.keyWindow {
     
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let photoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let photoPlayerView = PhotoPlayerView(frame: photoPlayerFrame)
            photoPlayerView.photoImageView?.setupImage(url: package.photo)
            
            view.addSubview(photoPlayerView)
            
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
