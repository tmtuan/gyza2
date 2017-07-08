//
//  ViewController.swift
//  Gyza2
//
//  Created by Tran Minh Tuan on 7/5/17.
//  Copyright © 2017 Tran Minh Tuan. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: Properties
    var packages = [Package]()
    
    // MARK: Methods
    func fetchPackages() {
        let url = URL(string: "https://api.gyza.vn/api/packages")
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
            
            } catch let jsonError {
                print(jsonError)
            }
            
            
        }.resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchPackages()
        
        navigationItem.title = "Gyza"
        
        collectionView?.backgroundColor = UIColor.white
        
        let cellIdentifier = "cellId"
        collectionView?.register(PackageCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
       
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

