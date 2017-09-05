//
//  IntroViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 9/4/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let cellId = "cellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "Lifestyle", message: "Choose your interior design", imageName: "IntroPage01")
        let secondPage = Page(title: "Share", message: "Share your design interests", imageName: "IntroPage02")
        let thirdPage = Page(title: "Order", message: "Get furniture from credible manufacturers", imageName: "IntroPage03")
        let fourthPage = Page(title: "Enjoy", message: "Enjoy your home", imageName: "IntroPage04")
        return [firstPage, secondPage, thirdPage, fourthPage ]
    }()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        collectionView.frame = view.frame
        view.addSubview(collectionView)

        collectionView.register(IntroPageCell.self, forCellWithReuseIdentifier: cellId)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IntroPageCell
        
        let page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
