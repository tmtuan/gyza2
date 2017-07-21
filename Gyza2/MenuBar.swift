//
//  MenuBar.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/21/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.red
        return cv
    }()
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.red
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
