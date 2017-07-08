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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
        addSubview(thumbnailImageView)
        thumbnailImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: thumbnailImageView)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
