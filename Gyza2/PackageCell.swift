//
//  PackageCell.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/8/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class PackageCell: CustomCollectionViewCell {
    
    // MARK: Properties
    
    var packageController: HomeController?
    
    var package: Package? {
        didSet {
        
            thumbnailImageView.setupImage(url: package?.photo, imageCache: imageCache)
            publisherProfileImageView.setupImage(url: package?.user?.avatar, imageCache: imageCache)
            nameLabel.text = package?.name
            titleLabel.text = package?.designer
            if let height = (thumbnailImageView.image?.size.height) {
                if (package?.photoHeight == 0.0 ) {
                    package?.photoHeight = height
                }
            }
            
        }
    }
    
    let thumbnailImageView: CustomImageView = {
        let imageView =  CustomImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let publisherProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor  = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1).cgColor
        imageView.clipsToBounds = true
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
    func animate() {
        packageController?.animateImageview(thumbnailImageView: thumbnailImageView)
    }
    
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
    
    override func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(publisherProfileImageView)
        addSubview(nameLabel)
        addSubview(titleLabel)
        
        thumbnailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PackageCell.animate as (PackageCell) -> () -> ())))
        
        // Horizontal Constraints
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|", views: publisherProfileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|", views: publisherProfileImageView, titleLabel)
        
        // Vertical Constraints
        
        addConstraintsWithFormat(format: "V:|-0-[v0]-8-[v1(44)]-8-|", views: thumbnailImageView, publisherProfileImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-[v1(20)]-8-[v2(20)]", views: thumbnailImageView, nameLabel, titleLabel)
        
    }

}

