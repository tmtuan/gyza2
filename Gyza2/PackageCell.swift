//
//  PackageCell.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/8/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class PackageCell: UICollectionViewCell {
    
    // MARK: Properties
    var package: Package? {
        didSet {
            
            //setupImage(imageView: thumbnailImageView, url: package?.photo)
            //setupImage(imageView: publisherProfileImageView, url: package?.user?.avatar)
            thumbnailImageView.setupImage(url: package?.photo, imageCache: imageCache)
            publisherProfileImageView.setupImage(url: package?.user?.avatar, imageCache: imageCache)
            nameLabel.text = package?.name
            titleLabel.text = package?.designer
            
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView =  CustomImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return imageView
    }()
    
    let publisherProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        return title
    }()
    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Cache images for better display
    let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: Methods
    
    // Load image from url string
    func setupImage(imageView: UIImageView, url: String?) {
        
    
        
        imageView.image = nil
       
        if let imageUrl = url {
            
            if let imageFromCache = imageCache.object(forKey: NSString(string: imageUrl)) {
                imageView.image = imageFromCache
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
                    
                    self.imageCache.setObject(imageToCache!, forKey: NSString(string: imageUrl))
                    
                    imageView.image = imageToCache
                }
            }).resume()
        }

    }
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(publisherProfileImageView)
        addSubview(nameLabel)
        addSubview(titleLabel)
        addSubview(separatorView)
        
        
        
        // Horizontal Constraints
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|", views: publisherProfileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|", views: publisherProfileImageView, titleLabel)
        
        // Vertical Constraints
        
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, publisherProfileImageView, separatorView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(20)]-8-[v2(20)]", views: thumbnailImageView, nameLabel, titleLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
       
    }
    
    
}

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
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
