//
//  CustomImageView.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/2/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func setupImage(url: String?) {
        
        imageUrlString = url
        
        self.image = nil
        
        if let imageUrl = url {
            
            let url = URL(string: imageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    
                    self.image = UIImage(data: data!)
                    
                }
            }).resume()
        }
    }
    
    
    func setupImage(url: String?, imageCache: NSCache<NSString, UIImage>) {
        
        imageUrlString = url
        
        self.image = nil
        
        if let imageUrl = url {
            
            if let imageFromCache = imageCache.object(forKey: NSString(string: imageUrl)) {
                self.image = imageFromCache
                return
            }
            
            let url = URL(string: imageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    
                    let imageToCache = UIImage(data: data!)
                    
                    if self.imageUrlString == imageUrl {
                        self.image = imageToCache
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: NSString(string: imageUrl))
                    
                    
                }
            }).resume()
        }
    }
    
}

