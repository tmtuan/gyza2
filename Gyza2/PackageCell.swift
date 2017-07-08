//
//  PackageCell.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/8/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class PackageCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
