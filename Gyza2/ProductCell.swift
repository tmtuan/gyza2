//
//  ProductCell.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/2/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class ProductCell: CustomCollectionViewCell {
    
    // MARK: Properties
    
    var product: Product? {
        didSet {
            thumbnailImageView.setupImage(url: product?.photo)
        }
    }
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "samplePhoto")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
 
    // Cache images for better display
    //let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setups
    override func setupViews() {
        addSubview(thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-0-[v0]-0-|", views: thumbnailImageView)
        
    }
}
