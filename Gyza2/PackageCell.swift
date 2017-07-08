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
    let thumbnailImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return imageView
    }()
    
    let publisherProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.black
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purple
        return label
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.backgroundColor = UIColor.red
        return title
    }()
    
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
