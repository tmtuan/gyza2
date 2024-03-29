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
    let loginCellId = "loginCellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "Lifestyle", message: "Choose your interior design", imageName: "IntroPage01")
        let secondPage = Page(title: "Share", message: "Share your design interests", imageName: "IntroPage02")
        let thirdPage = Page(title: "Order", message: "Get furniture from credible manufacturers", imageName: "IntroPage03")
        let fourthPage = Page(title: "Enjoy", message: "Enjoy your home", imageName: "IntroPage04")
        return [firstPage, secondPage, thirdPage, fourthPage ]
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.numberOfPages = self.pages.count
        pc.currentPageIndicatorTintColor = UIColor.black
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotification()
        view.backgroundColor = UIColor.yellow
        collectionView.frame = view.frame
        
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        
        // PageControl's constraints
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageControlBottomAnchor = pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        pageControlBottomAnchor?.isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerCells()
    }
    
    fileprivate func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    }
    
    func skipLogin() {
        dismiss(animated: true, completion: nil)
    }
    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width:self.view.frame.width, height:self.view.frame.height)
        }, completion: nil)
        print("keyboard shown")
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width:self.view.frame.width, height:self.view.frame.height)
        }, completion: nil)
        print("keyboard hide")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    fileprivate func registerCells() {
        collectionView.register(IntroPageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.introViewController = self
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IntroPageCell
        
        let page = pages[indexPath.item]
        
        cell.page = page
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        // on the last page
        if pageNumber == pages.count {
            pageControlBottomAnchor?.constant = 30
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            pageControlBottomAnchor?.constant = 0
        }
    }
}
