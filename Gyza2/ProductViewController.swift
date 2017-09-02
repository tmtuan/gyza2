//
//  ProductViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/1/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class ProductViewController: UICollectionViewController {
    
    // MARK: Propertes
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        
        navigationItem.title = "Product"
        
        
        setupCollectionView()
    }
    
    // MARK: setup
    
    func setupCollectionView() {
        
        collectionView?.backgroundColor = UIColor.init(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = true
    
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        
    }

    // MARK: collectionView delegates
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.red
        return cell
        
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = view.frame.width / 3.0 - 1 - 1
        return CGSize(width: size, height: size)
    }
    
}
